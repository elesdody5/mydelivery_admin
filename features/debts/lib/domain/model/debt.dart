import 'dart:ffi';

import 'package:core/domain/user.dart';

class Debt {
  String? id;
  User? userAdded;
  String? title;
  double? totalAmount;
  String? phone;
  DateTime? createdAt;

  Debt(
      {this.id,
      this.userAdded,
      this.title,
      this.totalAmount,
      this.phone,
      this.createdAt});

  factory Debt.fromJson(Map<String, dynamic> json, String id) => Debt(
      id: id,
      userAdded: User.fromJson(json["user"]),
      totalAmount: json["price"],
      phone: json["phone"],
      createdAt: json["created_at"] != null ? DateTime.parse(json['created_at']) : null,
      title: json['title']);

  Map<String, dynamic> toJson() => {
        "user": userAdded?.toJson(),
        "price": totalAmount,
        "title": title,
        "phone": phone,
        "created_at": createdAt?.toIso8601String()
      };
}
