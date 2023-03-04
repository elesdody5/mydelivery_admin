import 'package:cool_alert/cool_alert.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/domain/model/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationMessage notificationMessage;
  final Function sendNotification;

  NotificationDialog(
      {Key? key,
      required this.notificationMessage,
      required this.sendNotification})
      : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void _submit() {
    try {
      if (_fbKey.currentState?.validate() == true) {
        _fbKey.currentState?.save();
        Get.back();
        sendNotification();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("send_notification".tr),
      content: FormBuilder(
          key: _fbKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'title',
                  validator: FormBuilderValidators.required(Get.context!),
                  onSaved: (String? title) => notificationMessage.title = title,
                  decoration:
                      formInputDecoration(label: 'notification_title'.tr),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'body',
                  maxLines: 2,
                  validator: FormBuilderValidators.required(Get.context!),
                  onSaved: (String? body) => notificationMessage.message = body,
                  decoration:
                      formInputDecoration(label: 'notification_message'.tr),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown<UserType>(
                  name: "userType",
                  decoration: formInputDecoration(label: "user".tr),
                  initialValue: UserType.user,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      context,
                    ),
                  ]),
                  onSaved: (UserType? userType) =>
                      notificationMessage.userType = userType,
                  items: UserType.values
                      .map((userType) => DropdownMenuItem(
                            value: userType,
                            child: Text(userType.name.tr),
                          ))
                      .toList(),
                ),
              ),
            ],
          )),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
        TextButton(onPressed: _submit, child: Text("send".tr)),
      ],
    );
  }
}
