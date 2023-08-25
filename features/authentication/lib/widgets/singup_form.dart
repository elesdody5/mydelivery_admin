import 'dart:io';

import 'package:authentication/domin/model/signup_model.dart';
import 'package:authentication/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class SignupForm extends StatelessWidget {
  final SignUpModel signUpModel;
  final void Function() signup;

  SignupForm({
    required this.signUpModel,
    required this.signup,
  });
  
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    signup();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 160,
              child: FormBuilderImagePicker(
                name: 'photos',
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  label: Text("Pick picture"),
                ),
                maxImages: 1,
                fit: BoxFit.cover,
                previewWidth: 160,
                iconColor: Colors.grey,
                onSaved: (image) {
                  if (image?[0] != null) {
                    signUpModel.imageFile = File(image?[0]?.path);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "name",
                onSaved: (String? name) {
                  if (name != null) signUpModel.name = name;
                },
                decoration: formInputDecoration(label: "user_name".tr),
                validator: FormBuilderValidators.required(
                    errorText: "please_enter_name".tr)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "phone",
                onSaved: (String? phone) {
                  if (phone != null) signUpModel.phone = phone;
                },
                decoration: formInputDecoration(label: "phone".tr),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'please_enter_valid_phone'.tr,
                  ),
                  FormBuilderValidators.match(
                    r'(^(?:[+0]9)?[0-9]{10,12}$)',
                    errorText: 'please_enter_valid_phone'.tr,
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: "address",
              onSaved: (String? address) {
                if (address != null) signUpModel.address = address;
              },
              decoration: formInputDecoration(label: "address".tr),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
                name: "password",
                controller: _pass,
                obscureText: true,
                onSaved: (String? password) {
                  if (password != null) signUpModel.password = password;
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
            child: FormBuilderTextField(
              name: "confirm_password",
              obscureText: true,
              controller: _confirmPass,
              onSaved: (String? confirm) {
                signUpModel.confirmPassword = confirm;
              },
              decoration: formInputDecoration(label: "confirm_password".tr),
              validator: FormBuilderValidators.compose(([
                (value) => _pass.text != _confirmPass.text
                    ? "password_not_match".tr
                    : null
              ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(
                "sign_up".tr,
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
