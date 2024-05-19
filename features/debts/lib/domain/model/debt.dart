import 'dart:ffi';

import 'package:core/domain/user.dart';

import 'debts_transactions.dart';

class Debt {
  String? id;
  User? userAdded;
  String? title;
  double? totalAmount;
  String? phone;
  DateTime? createdAt;
  TransactionType? type;

  Debt(
      {this.id,
      this.userAdded,
      this.title,
      this.totalAmount,
      this.phone,
      this.createdAt,
      this.type});

  factory Debt.fromJson(Map<String, dynamic> json, String id) => Debt(
      id: id,
      userAdded: User.fromJson(json["user"]),
      totalAmount: json["price"],
      phone: json["phone"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json['created_at'])
          : null,
      title: json['title'],
      type: json['type'] != null
          ? TransactionType.values
              .firstWhere((element) => element.name == json['type'])
          : null);

  Map<String, dynamic> toJson() => {
        "user": userAdded?.toJson(),
        "price": totalAmount,
        "title": title,
        "phone": phone,
        "type": type?.name,
        "created_at": createdAt?.toIso8601String()
      };
}
