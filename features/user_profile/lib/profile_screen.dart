import 'dart:io';

import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/profile_provider.dart';
import 'package:widgets/future_with_loading_progress.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("profile".tr),
        ),
        body: FutureWithLoadingProgress(
          future: provider.getUserDetails,
          child: Consumer<ProfileProvider>(builder: (context, provider, child) {
            return FormBuilder(
              key: _formKey,
              child: Column(
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
                            provider.user?.imageFile = File(image?[0]?.path);
                          }
                        },
                        initialValue: [provider.user?.imageUrl],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                        name: "name",
                        enabled: provider.editAble,
                        onSaved: (String? name) {
                          if (name != null) provider.user?.name = name;
                        },
                        initialValue: provider.user?.name,
                        decoration: formInputDecoration(
                            label: "user_name".tr,
                            suffixIcon:
                                const Icon(Icons.supervised_user_circle)),
                        validator: FormBuilderValidators.required(context,
                            errorText: "please_enter_name".tr)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                        name: "phone",
                        onSaved: (String? phone) {
                          if (phone != null) provider.user?.phone = phone;
                        },
                        initialValue: provider.user?.phone,
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
                        onSaved: (String? address) {
                          if (address != null) provider.user?.address = address;
                        },
                        initialValue: provider.user?.address,
                        decoration: formInputDecoration(
                            label: "address".tr,
                            suffixIcon: const Icon(Icons.my_location_rounded)),
                      )),

                ],
              ),
            );
          }),
        ));
  }
}
