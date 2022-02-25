import 'package:core/utils/utils.dart';
import 'package:dashboard/domain/model/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';

import 'notification_provider.dart';
import 'widget/notification_list_item.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  void _showAlertDialog(NotificationListProvider provider,
      NotificationMessage notificationMessage) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_notification".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.deleteNotificationById(notificationMessage);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<NotificationListProvider>(context, listen: false);
    setupLoadingListener(provider.isLoading);
    setupErrorMessageListener(provider.errorMessage);
    return Scaffold(
      appBar: AppBar(
        title: Text("notifications".tr),
      ),
      body: FutureWithLoadingProgress(
        future: provider.getAllNotification,
        child: Consumer<NotificationListProvider>(
            builder: (_, provider, child) => ListView.builder(
                itemCount: provider.notifications.length,
                itemBuilder: (context, index) => NotificationListItem(
                    notificationMessage: provider.notifications[index],
                    deleteNotification: (notification) =>
                        _showAlertDialog(provider, notification),
                    index: index))),
      ),
    );
  }
}
