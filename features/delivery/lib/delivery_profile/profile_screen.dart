import 'dart:io';

import 'package:core/domain/user.dart';
import 'package:core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:widgets/user_avatar.dart';

class DeliveryProfileScreen extends StatelessWidget {
  DeliveryProfileScreen({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    User delivery = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("profile".tr),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UserAvatar(
                        id: delivery.id ?? "",
                        imageUrl: delivery.imageUrl,
                        radius: 50,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "name",
                      onSaved: (String? name) {
                        if (name != null) delivery.name = name;
                      },
                      initialValue: delivery.name,
                      decoration: formInputDecoration(
                          label: "delivery_name".tr,
                          suffixIcon: const Icon(Icons.supervised_user_circle)),
                      validator: FormBuilderValidators.required(context,
                          errorText: "please_enter_name".tr)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "phone",
                      onSaved: (String? phone) {
                        if (phone != null) delivery.phone = phone;
                      },
                      initialValue: delivery.phone,
                      decoration: formInputDecoration(
                          label: "phone".tr,
                          suffixIcon: const Icon(Icons.phone)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: 'please_enter_valid_phone'.tr,
                        ),
                        FormBuilderValidators.match(
                          context,
                          r'(^(?:[+0]9)?[0-9]{10,12}$)',
                          errorText: 'please_enter_valid_phone'.tr,
                        ),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                      name: "address",
                      readOnly: true,
                      initialValue: delivery.address,
                      onSaved: (String? address) {
                        if (address != null) {
                          delivery.address = address;
                        }
                      },
                      decoration: formInputDecoration(
                          label: "address".tr,
                          suffixIcon: const Icon(Icons.my_location_rounded)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: 'please_enter_address'.tr,
                        ),
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
