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

  SafeTransaction(
      {this.id,
      this.userAdded,
      this.delivery,
      this.amount,
      this.transactionType,
      this.addingType,
      this.createdAt});

  SafeTransaction.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    amount = json['amount'];
    userAdded = User.fromJson(json['user']);
    delivery = User.fromJson(json['delivery']);
    transactionType = TransactionType.values.firstWhere(
        (e) => e.name.toLowerCase() == json['transactionType'].toLowerCase());
    addingType = AddingType.values.firstWhere(
        (e) => e.name.toLowerCase() == json['addingType'].toLowerCase());
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = json['updatedAt'];
  }
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
