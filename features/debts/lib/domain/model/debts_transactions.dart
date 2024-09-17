import 'dart:ffi';

import 'package:core/domain/user.dart';

class DebtTransaction {
  String? id;
  String? debtId;
  User? userAdded;
  DateTime? createdAt;
  double? amount;
  TransactionType? transactionType;
  String? reason;
  String? deliveryName;

  DebtTransaction(
      {this.id,
      this.debtId,
      this.userAdded,
      this.createdAt,
      this.amount,
      this.reason,
      this.deliveryName,
      this.transactionType});

  factory DebtTransaction.fromJson(Map<String, dynamic> json, String? id) =>
      DebtTransaction(
          id: id,
          debtId: json["debt_id"],
          userAdded: User.fromJson(json["user"]),
          createdAt: json["created_at"] != null
              ? DateTime.parse(json['created_at'])
              : null,
          amount: json["amount"],
          reason: json['reason'],
          deliveryName: json["delivery_name"],
          transactionType: TransactionType.values.firstWhere(
              (element) => element.name == json['transaction_type']));

  Map<String, dynamic> toJson() => {
        "debt_id": debtId,
        "user": userAdded?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "amount": amount,
        "reason": reason,
        "delivery_name": deliveryName,
        "transaction_type": transactionType?.name
      };
}

enum TransactionType { adding, deduction }
