import 'dart:io';

import 'package:core/domain/quick_order.dart';
import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'record_widget.dart';
import 'record_widget_provider.dart';

class QuickOrderAlert extends StatelessWidget {
  final Function() sendQuickOrder;
  final QuickOrder quickOrder;
  final String title;

  QuickOrderAlert(
      {Key? key,
      required this.quickOrder,
      required this.sendQuickOrder,
      required this.title})
      : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
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
                  onSaved: (bool? value) => quickOrder.inCity = value,
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
                  onSaved: (int? value) => quickOrder.count = value,
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
                  child: FormBuilderTextField(
                    name: "phone",
                    onSaved: (String? phone) => quickOrder.phoneNumber = phone,
                    decoration: formInputDecoration(label: "phone".tr),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: "address",
                    onSaved: (String? address) => quickOrder.address = address,
                    decoration: formInputDecoration(label: "address".tr),
                  )),
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
                      quickOrder.imageFile = File(image?[0]?.path);
                    }
                  },
                ),
              ),
              Text("${"add_record".tr} (${"optional".tr})"),
              ChangeNotifierProvider.value(
                  value: RecordProvider(quickOrder: quickOrder),
                  child: const RecordWidget()),
              Divider(
                color: Get.theme.primaryIconTheme.color,
              ),
              FormBuilderTextField(
                name: "description",
                minLines: 5,
                maxLines: 10,
                onSaved: (String? description) =>
                    quickOrder.description = description,
                decoration: formInputDecoration(label: "description".tr),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                _formKey.currentState?.save();
                Get.back();
                sendQuickOrder();
              }
            },
            child: Text("confirm".tr)),
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
      ],
    );
  }
}
