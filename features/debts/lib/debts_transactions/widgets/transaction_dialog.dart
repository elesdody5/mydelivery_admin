import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TransactionDialog extends StatelessWidget {
  final Function(String, String, String) addTransaction;

  TransactionDialog({Key? key, required this.addTransaction}) : super(key: key);

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();

  void _submit() {
    if (_priceController.text.isNotEmpty) {
      Get.back();
      addTransaction(_priceController.text, _reasonController.text,
          _deliveryController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("add_debts".tr),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderTextField(
              name: 'price',
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: formInputDecoration(label: 'price'.tr),
            ),
            FormBuilderTextField(
              name: 'reason',
              controller: _reasonController,
              keyboardType: TextInputType.text,
              decoration: formInputDecoration(label: 'reason'.tr),
            ),
            FormBuilderTextField(
              name: 'delivery',
              controller: _deliveryController,
              keyboardType: TextInputType.text,
              decoration: formInputDecoration(
                  label: "${"delivery".tr} (${"optional".tr})"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("save".tr)),
      ],
    );
  }
}
