import 'dart:ffi';

import 'package:core/domain/user.dart';

class DebtTransaction {
  String? id;
  String? debtId;
  User? userAdded;
  DateTime? createdAt;
  double? amount;
  TransactionType? transactionType;

  DebtTransaction(
      {this.id,
      this.debtId,
      this.userAdded,
      this.createdAt,
      this.amount,
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
          transactionType: TransactionType.values.firstWhere(
              (element) => element.name == json['transaction_type']));

  Map<String, dynamic> toJson() => {
        "debt_id": debtId,
        "user": userAdded?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "amount": amount,
        "transaction_type": transactionType?.name
      };
}

enum TransactionType { adding, deduction }
