import 'package:core/domain/user_type.dart';

class NotificationMessage {
  String? id;
  String? title;
  String? message;
  UserType? userType;

  NotificationMessage({this.title, this.message, this.id,this.userType});

  Map<String, String?> toJson() => {"title": title, "msg": message};

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      NotificationMessage(
          id: json['_id'], title: json["title"], message: json['msg']);
}
