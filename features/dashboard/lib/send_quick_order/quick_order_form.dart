import 'dart:io';
import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/model/shop.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/domain/model/PhoneContact.dart';
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
    _setupSuccessMessageListener(provider.successMessage);
  }

  void _setupSuccessMessageListener(RxnString successMessage) {
    ever(successMessage, (String? message) {
      if (message != null) {
        _showSuccessDialog(message.tr);
        successMessage.clear();
      }
    });
  }

  void _showSuccessDialog(String message) {
    CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        text: message,
        onConfirmBtnTap: () {
          Get.back();
          Get.back();
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<QuickOrderFormProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
      appBar: AppBar(
        title: Text("quick_order".tr),
        centerTitle: true,
      ),
      body: FutureWithLoadingProgress(
        future: provider.init,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
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
                      initialValue: true,
                      validator: FormBuilderValidators.required(context),
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
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: FormBuilderDropdown(
                      decoration:
                          InputDecoration(labelText: 'order_places_count'.tr),
                      name: 'count',
                      initialValue: 1,
                      onChanged: (int? value) {
                        if (value != null) {
                          _priceController.text = (value * 10).toString();
                        }
                      },
                      validator: FormBuilderValidators.required(context),
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text("${"add_photo".tr} (${"optional".tr}) "),
                      ),
                      maxImages: 1,
                      fit: BoxFit.cover,
                      iconColor: Colors.grey,
                      onSaved: (image) {
                        if (image?[0] != null && image?[0] is! String) {
                          provider.quickOrder.imageFile = File(image?[0]?.path);
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
                    minLines: 5,
                    maxLines: 10,
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
                        child: Text("confirm".tr)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
