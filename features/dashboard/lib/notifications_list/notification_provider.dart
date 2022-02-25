import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

import '../data/repository/repository.dart';
import '../domain/model/notification_message.dart';

class NotificationListProvider extends BaseProvider {
  final Repository _repository;
  List<NotificationMessage> notifications = [];

  NotificationListProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getAllNotification() async {
    Result result = await _repository.getAllNotifications();
    if (result.succeeded()) {
      notifications = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> deleteNotificationById(
      NotificationMessage notificationMessage) async {
    isLoading.value = true;
    Result result =
        await _repository.deleteNotificationById(notificationMessage.id ?? "");
    isLoading.value = true;
    if (result.succeeded()) {
      notifications.remove(notificationMessage);
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
}
