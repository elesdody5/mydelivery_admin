import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/city.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/model/shop.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:quickorder/domain/model/PhoneContact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'QuickOrderFormProvider.dart';
import 'record_widget.dart';
import 'record_widget_provider.dart';

class QuickOrderForm extends StatelessWidget {
  QuickOrderForm({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController =
      TextEditingController(text: "10");

  void _setupListener(QuickOrderFormProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    _setupSuccessMessageListener(provider);
  }

  void _setupSuccessMessageListener(QuickOrderFormProvider provider) {
    ever(provider.successMessage, (String? message) {
      if (message != null) {
        _showSuccessDialog(
          provider.quickOrder,
          message.tr,
        );
        provider.successMessage.clear();
      }
    });
  }

  void _showSuccessDialog(QuickOrder quickOrder, String message) {
    CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        text: message,
        onConfirmBtnTap: () {
          Get.back(result: quickOrder);
          Get.back(result: quickOrder);
        });
  }

  void _setInitValue(QuickOrder? quickOrder) {
    if (quickOrder != null) {
      _phoneController.text = quickOrder.phoneNumber ?? "";
      _priceController.text = quickOrder.price?.toString() ?? "";
      _typeAheadController.text = quickOrder.address ?? "";
      _descriptionController.text = quickOrder.description ?? "";
    }
  }

  Future<void> _pickMinutes(QuickOrderFormProvider provider) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now().replacing(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'schedule_quick_order'.tr,
      confirmText: 'confirm'.tr,
    );
    if (picked != null) {
      final int hours = picked.hour;
      final int minutes = picked.minute;
      provider.scheduleQuickOrder(Duration(hours: hours, minutes: minutes));
    }
  }

  @override
  Widget build(BuildContext context) {
    QuickOrder? quickOrder = Get.arguments;
    final provider =
        Provider.of<QuickOrderFormProvider>(context, listen: false);
    _setupListener(provider);
    _setInitValue(quickOrder);
    return Scaffold(
      appBar: AppBar(
        title: Text("quick_order".tr),
        centerTitle: true,
      ),
      body: FutureWithLoadingProgress(
        future: () => provider.init(quickOrder),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<QuickOrderFormProvider>(
                builder: (context, provider, key) {
              return FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: FormBuilderRadioGroup<bool>(
                        decoration: InputDecoration(labelText: 'type'.tr),
                        name: 'type',
                        initialValue: provider.quickOrder.inCity ?? true,
                        validator: FormBuilderValidators.required(),
                        onChanged: (bool? inMenouf) => provider
                            .toggleCitiesVisibility(!(inMenouf ?? false)),
                        onSaved: (bool? value) =>
                            provider.quickOrder.inCity = value,
                        options: [
                          "in_menouf",
                          "out_menouf",
                        ]
                            .map((type) => FormBuilderFieldOption(
                                  value: type == "in_menouf",
                                  child: Text(type.tr),
                                ))
                            .toList(growable: false),
                      ),
                    ),
                    if (provider.showCities)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FormBuilderDropdown<City>(
                          decoration: InputDecoration(
                              labelText: 'cities_out_menouf'.tr),
                          name: 'cities',
                          onChanged: (City? value) {
                            if (value != null) {
                              _priceController.text = value.price.toString();
                              _typeAheadController.text =
                                  "${value.name}  " ?? "";
                              provider.selectedCity = value;
                            }
                          },
                          items: provider.cities
                              .map((city) => DropdownMenuItem(
                                    value: city,
                                    child: Text(city.name ?? ""),
                                  ))
                              .toList(growable: false),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: FormBuilderDropdown(
                        decoration:
                            InputDecoration(labelText: 'order_places_count'.tr),
                        name: 'count',
                        initialValue: provider.quickOrder.count ?? 1,
                        onChanged: (int? value) {
                          onCountChange(value, provider);
                        },
                        validator: FormBuilderValidators.required(),
                        onSaved: (int? value) =>
                            provider.quickOrder.count = value,
                        items: [1, 2, 3, 4, 5]
                            .map((count) => DropdownMenuItem(
                                  value: count,
                                  child: Text("$count"),
                                ))
                            .toList(growable: false),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TypeAheadFormField<PhoneContact>(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: formInputDecoration(label: 'phone'.tr),
                            controller: _phoneController,
                          ),
                          onSuggestionSelected: (PhoneContact contact) {
                            _phoneController.text = contact.number;
                          },
                          onSaved: (String? value) =>
                              provider.quickOrder.phoneNumber = value,
                          itemBuilder:
                              (BuildContext context, PhoneContact contact) {
                            return ListTile(
                              title: Text(contact.name),
                              subtitle: Text(contact.number),
                            );
                          },
                          suggestionsCallback: (pattern) {
                            return provider.phoneContacts.where((contact) =>
                                contact.name
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()));
                          },
                        )),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TypeAheadFormField<Shop>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration:
                                      formInputDecoration(label: 'address'.tr),
                                  controller: _typeAheadController,
                                ),
                                onSuggestionSelected: (Shop shop) {
                                  _typeAheadController.text = shop.name ?? "";
                                },
                                onSaved: (String? value) =>
                                    provider.quickOrder.address = value,
                                itemBuilder: (BuildContext context, Shop shop) {
                                  return ListTile(
                                    title: Text(shop.name ?? ""),
                                    subtitle: Text(shop.address ?? ""),
                                  );
                                },
                                suggestionsCallback: (pattern) {
                                  return provider.shops.where((shop) =>
                                      shop.name
                                          ?.toLowerCase()
                                          .contains(pattern.toLowerCase()) ??
                                      false);
                                },
                              )),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FormBuilderTextField(
                                controller: _priceController,
                                name: 'price',
                                onSaved: (String? price) {
                                  if (price != null) {
                                    provider.quickOrder.price =
                                        int.tryParse(price);
                                  }
                                },
                                decoration: formInputDecoration(
                                    label: "delivery_price".tr,
                                    suffixText: "le".tr),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: FormBuilderImagePicker(
                        name: 'photo',
                        imageQuality: 70,
                        initialValue: provider.quickOrder.imageFile != null
                            ? [provider.quickOrder.imageFile]
                            : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text("${"add_photo".tr} (${"optional".tr}) "),
                        ),
                        maxImages: 1,
                        fit: BoxFit.cover,
                        iconColor: Colors.grey,
                        onSaved: (image) {
                          if (image?[0] != null && image?[0] is! String) {
                            provider.quickOrder.imageFile =
                                File(image?[0]?.path);
                          }
                        },
                      ),
                    ),
                    Text("${"add_record".tr} (${"optional".tr})"),
                    ChangeNotifierProvider.value(
                        value: RecordProvider(quickOrder: provider.quickOrder),
                        child: const RecordWidget()),
                    Divider(
                      color: Get.theme.primaryIconTheme.color,
                    ),
                    FormBuilderTextField(
                      name: "description",
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 6,
                      onTap: () {
                        if (_descriptionController.selection ==
                            TextSelection.fromPosition(TextPosition(
                                offset:
                                    _descriptionController.text.length - 1))) {
                          _descriptionController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _descriptionController.text.length));
                        }
                      },
                      onSaved: (String? description) =>
                          provider.quickOrder.description = description,
                      decoration: formInputDecoration(
                        label: "description".tr,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();
                              provider.sendQuickOrder();
                            }
                          },
                          child: Text(provider.quickOrder.id == null
                              ? "confirm".tr
                              : "update".tr)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();
                              _pickMinutes(provider);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.schedule_outlined,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("schedule_quick_order".tr),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void onCountChange(int? value, QuickOrderFormProvider provider) {
    if (value != null) {
      if (provider.showCities) {
        _priceController.text =
            (value * (provider.selectedCity?.price ?? 1)).toString();
      } else {
        _priceController.text = (value * 10).toString();
      }
    }
  }
}
