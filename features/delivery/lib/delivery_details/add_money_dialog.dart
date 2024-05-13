import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
class AddMoneyDialog extends StatelessWidget {
  final Function(String) add;

  AddMoneyDialog({Key? key, required this.add}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _priceController = TextEditingController();

  void _submit() {
    try {
      if (_fbKey.currentState?.validate() == true) {
        _fbKey.currentState?.save();
        Get.back();
        add(_priceController.text);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("adding".tr),
      content: FormBuilder(
          key: _fbKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'title',
                  controller: _priceController,
                  validator: FormBuilderValidators.required(),
                  keyboardType: TextInputType.number,
                  decoration: formInputDecoration(),
                ),
              ),
            ],
          )),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("save".tr)),
      ],
    );
  }
}
