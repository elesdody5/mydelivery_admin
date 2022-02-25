import 'package:dashboard/domain/model/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationMessage notificationMessage;
  final int index;
  final Function(NotificationMessage) deleteNotification;

  const NotificationListItem(
      {Key? key,
      required this.notificationMessage,
      required this.index,
      required this.deleteNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => deleteNotification(notificationMessage),
      leading: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor, shape: BoxShape.circle),
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      title: Text(notificationMessage.title ?? ""),
      subtitle: Text(notificationMessage.message ?? ""),
    );
  }
}
