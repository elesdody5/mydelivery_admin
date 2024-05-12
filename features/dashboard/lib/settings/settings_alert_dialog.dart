import 'package:core/utils/styles.dart';
import 'package:core/model/order_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SettingsAlertDialog extends StatelessWidget {
  final OrderSettings? orderSettings;
  final Function() updateOrderSettings;

  SettingsAlertDialog(
      {Key? key,
      required this.orderSettings,
      required this.updateOrderSettings})
      : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("settings".tr),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderSwitch(
              name: "enableOrders",
              initialValue: orderSettings?.enableOrders,
              onChanged: (bool? value) => orderSettings?.enableOrders = value,
              title: Text("enable_orders".tr),
              validator: FormBuilderValidators.required(),
            ),
            FormBuilderTextField(
                name: "firstOrder",
                keyboardType: TextInputType.number,
                initialValue: orderSettings?.firstRidePrice.toString(),
                onSaved: (String? firstOrder) {
                  orderSettings?.firstRidePrice = int.parse(firstOrder ?? "0");
                },
                decoration: formInputDecoration(label: "first_drive".tr),
                validator: FormBuilderValidators.required()),
            FormBuilderTextField(
                name: "otherOrders",
                keyboardType: TextInputType.number,
                initialValue: orderSettings?.otherRidePrice.toString(),
                onSaved: (String? otherRide) {
                  orderSettings?.otherRidePrice = int.parse(otherRide ?? "0");
                },
                decoration: formInputDecoration(label: "other_drive".tr),
                validator: FormBuilderValidators.required()),
            FormBuilderTextField(
                name: "office_percent",
                keyboardType: TextInputType.number,
                initialValue: orderSettings?.profitPercent.toString() ?? "0",
                onSaved: (String? profitPercent) {
                  orderSettings?.profitPercent =
                      double.parse(profitPercent ?? "0");
                },
                decoration: formInputDecoration(label: "office_percent".tr),
                validator: FormBuilderValidators.required()),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                _formKey.currentState?.save();
                Get.back();
                updateOrderSettings();
              }
            },
            child: Text("confirm".tr)),
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
      ],
    );
  }
}
