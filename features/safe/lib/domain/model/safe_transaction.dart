import 'package:core/domain/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SafeTransaction {
  String? id;
  num? amount;
  TransactionType? transactionType;
  AddingType? addingType;
  DateTime? createdAt;
  String? updatedAt;
  User? userAdded;
  User? delivery;
  String? reason;

  SafeTransaction(
      {this.id,
      this.userAdded,
      this.delivery,
      this.amount,
      this.transactionType,
      this.addingType,
      this.createdAt,
      this.reason});

  SafeTransaction.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    amount = json['amount'];
    userAdded = json["user"] != null ? User.fromJson(json['user']) : null;
    delivery =
        json["delivery"] != null ? User.fromJson(json['delivery']) : null;
    transactionType = json['transactionType'] != null
        ? TransactionType.values.firstWhere((e) =>
            e.name.toLowerCase() == json['transactionType'].toLowerCase())
        : null;
    addingType = AddingType.values.firstWhere(
        (e) => e.name.toLowerCase() == json['addingType'].toLowerCase());
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = json['updatedAt'];
    reason = json["reason"];
  }

  Map<String, dynamic> toJson() => {

        "amount": amount,
        "user": userAdded?.id,
        "delivery": delivery?.id,
        "transactionType": transactionType?.name.capitalizeFirst,
        "addingType": addingType?.name.capitalizeFirst,
        "reason": reason
      };

  String? get formattedTime {
    if (createdAt == null) return null;
    String formattedTime = DateFormat.jm().format(createdAt!);
    String am = "am".tr;
    String pm = "pm".tr;
    formattedTime = formattedTime.replaceAll("AM", am);
    formattedTime = formattedTime.replaceAll("PM", pm);
    return formattedTime;
  }

  String? get formattedDate {
    if (createdAt == null) return null;
    var dateFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = dateFormat.format(createdAt!);
    return formattedDate;
  }
}

enum AddingType { deduction, adding }

enum TransactionType { settle, custody }
