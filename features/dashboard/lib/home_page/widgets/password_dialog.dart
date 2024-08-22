import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class PasswordDialog extends StatelessWidget {
  final Function(String, String) submitPassword;
  final String destination;

  PasswordDialog(
      {Key? key, required this.submitPassword, required this.destination})
      : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    try {
      if (_fbKey.currentState?.validate() == true) {
        Get.back();
        submitPassword(_passwordController.text, destination);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("add_debts".tr),
      content: FormBuilder(
          key: _fbKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'password',
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: FormBuilderValidators.required(),
                  decoration: formInputDecoration(label: "password".tr),
                ),
              )
            ],
          )),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("login".tr)),
      ],
    );
  }
}
