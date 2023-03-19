import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/model/shop.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import 'QuickOrderFormProvider.dart';
import 'record_widget.dart';
import 'record_widget_provider.dart';

class QuickOrderForm extends StatelessWidget {
  QuickOrderForm({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
    Shop? shop = Get.arguments;
    final provider =
        Provider.of<QuickOrderFormProvider>(context, listen: false);
    provider.shop = shop;
    _setupListener(provider);
    return Scaffold(
      appBar: AppBar(
        title: Text("quick_order".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  onSaved: (bool? value) => provider.quickOrder.inCity = value,
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
                  validator: FormBuilderValidators.required(context),
                  onSaved: (int? value) => provider.quickOrder.count = value,
                  items: [1, 2, 3, 4, 5]
                      .map((count) => DropdownMenuItem(
                            value: count,
                            child: Text("$count"),
                          ))
                      .toList(growable: false),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          name: "address",
                          onSaved: (String? address) =>
                              provider.quickOrder.address = address,
                          decoration: formInputDecoration(label: "address".tr),
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          name: "price",
                          initialValue: "10",
                          onSaved: (String? price) {
                            if (price != null) {
                              provider.quickOrder.price = int.tryParse(price);
                            }
                          },
                          decoration: formInputDecoration(
                              label: "delivery_price".tr, suffixText: "le".tr),
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
                minLines: 5,
                maxLines: 10,
                onSaved: (String? description) =>
                    provider.quickOrder.description = description,
                decoration: formInputDecoration(label: "description".tr),
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
    );
  }
}
