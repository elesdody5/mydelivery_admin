import 'dart:io';

import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';
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

  Future<void> _submit(ProfileProvider provider) async {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    provider.updateUser();
  }

  void _setupListener(ProfileProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  @override
  Widget build(BuildContext context) {
    User? user = Get.arguments;
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
        appBar: AppBar(
          title: Text("profile".tr),
        ),
        body: FutureWithLoadingProgress(
          future: () => provider.getUserDetails(user),
          child: Consumer<ProfileProvider>(builder: (context, provider, child) {
            return SingleChildScrollView(
              child: FormBuilder(
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
                          enabled: false,
                          initialValue: [provider.user?.imageUrl],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                          name: "name",
                          enabled: user?.userType == UserType.delivery,
                          initialValue: provider.user?.name,
                          onSaved: (name) => provider.user?.name = name,
                          decoration: formInputDecoration(
                              label: "user_name".tr,
                              suffixIcon:
                                  const Icon(Icons.supervised_user_circle)),
                          validator: FormBuilderValidators.required(
                              errorText: "please_enter_name".tr)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                          name: "phone",
                          enabled: false,
                          readOnly: true,
                          initialValue: provider.user?.phone,
                          decoration: formInputDecoration(
                              label: "phone".tr,
                              suffixIcon: const Icon(Icons.phone)),
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
                          enabled: false,
                          readOnly: true,
                          initialValue: provider.user?.address,
                          decoration: formInputDecoration(
                              label: "address".tr,
                              suffixIcon:
                                  const Icon(Icons.my_location_rounded)),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          tileColor: Colors.white,
                          leading: Icon(
                            Icons.monetization_on_rounded,
                            color: Get.theme.primaryColor,
                          ),
                          title: Text("coin".tr),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Get.theme.primaryColor,
                                  ),
                                  onPressed: provider.increaseScore),
                              Text(provider.user?.coins?.toString() ?? "0"),
                              IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Get.theme.primaryColor,
                                  ),
                                  onPressed: provider.decreaseScore),
                            ],
                          )),
                    ),
                    if (user?.userType != UserType.delivery)
                      ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text("orders".tr),
                        leading: Image.asset(
                          'assets/images/delivery-man.png',
                          width: 20,
                          height: 20,
                        ),
                        children: [
                          ListTile(
                              onTap: () => Get.toNamed(currentUserOrdersScreen,
                                  arguments: provider.user?.id),
                              title: Text("current_orders".tr)),
                          ListTile(
                              onTap: () => Get.toNamed(
                                  deliveryDeliveredOrdersScreen,
                                  arguments: provider.user?.id),
                              title: Text("delivered_orders".tr)),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                          "save".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _submit(provider),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
