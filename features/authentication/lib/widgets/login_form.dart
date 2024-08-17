import 'package:authentication/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  final void Function(String?, String?) login;

  LoginForm({required this.login});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String? phone;
  String? password;

  void _submit() {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    login(phone, password);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "phone",
                onSaved: (String? phone) {
                  if (phone != null) {
                    this.phone = phone;
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: formInputDecoration(label: "phone".tr),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.match(
                    RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'),
                    errorText: 'please_enter_valid_phone'.tr,
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onSaved: (String? password) {
                  if (password != null) {
                    this.password = password;
                  }
                },
                decoration: formInputDecoration(label: "password".tr),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'please_enter_valid_password'.tr,
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(
                "login".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: _submit,
            ),
          ),
       
        ],
      ),
    );
  }
}
