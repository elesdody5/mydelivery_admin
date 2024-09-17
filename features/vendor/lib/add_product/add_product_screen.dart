import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/add_product/add_product_provider.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late AddProductProvider provider;

  void _submit() {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    provider.save();
  }

  void _setupListener() {
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
          Get.back(result: provider.product);
        });
  }

  @override
  Widget build(BuildContext context) {
    Product? product = Get.arguments?["product"];
    List<Category>? subCategory = Get.arguments?['subcategory'];
    String? shopId = Get.arguments?['shopId'];
    provider = Provider.of<AddProductProvider>(context, listen: false);
    provider.init(product, subCategory, shopId);
    _setupListener();
    return Scaffold(
        appBar: AppBar(),
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderImagePicker(
                    name: 'photos',
                    decoration: const InputDecoration(labelText: 'Pick Photos'),
                    maxImages: 1,
                    previewWidth: Get.width,
                    fit: BoxFit.cover,
                    previewHeight: 250,
                    iconColor: Colors.grey,
                    initialValue: [provider.product.image],
                    onSaved: (image) {
                      if (image?[0] != null) {
                        provider.product.imageFile = File(image?[0]?.path);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderDropdown<Category>(
                    name: "subcategory",
                    decoration: formInputDecoration(label: "category".tr),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onSaved: (Category? subCategory) =>
                        provider.product.subCategoryId = subCategory?.id,
                    items: provider.subCategory
                        .map((subCategory) => DropdownMenuItem(
                              value: subCategory,
                              child: Text('${subCategory.name}'),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "name",
                      initialValue: provider.product.name,
                      onSaved: (String? name) => provider.product.name = name,
                      decoration: formInputDecoration(label: "name".tr),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "price",
                      initialValue: provider.product.price?.toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (String? price) =>
                          provider.product.price = num.parse(price ?? "0"),
                      decoration: formInputDecoration(label: "price".tr),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "description",
                      initialValue: provider.product.description,
                      onSaved: (String? description) =>
                          provider.product.description = description,
                      decoration: formInputDecoration(
                          label: "${"description".tr} (${"optional".tr})"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      "save".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
