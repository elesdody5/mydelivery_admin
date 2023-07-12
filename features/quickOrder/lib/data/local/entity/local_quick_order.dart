import 'dart:io';

import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order_status.dart';
import 'package:core/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class LocalQuickOrder {
  int? id;
  String? address;
  bool? inCity;
  String? description;
  String? phoneNumber;
  int? count;
  DateTime? dateTime;
  String? imagePath;
  String? recordPath;
  int? price;

  LocalQuickOrder(
      {this.id,
      this.address,
      this.inCity,
      this.description,
      this.phoneNumber,
      this.count,
      this.dateTime,
      this.imagePath,
      this.recordPath,
      this.price});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'inCity': inCity == true ? 1 : 0,
      'description': description,
      'phoneNumber': phoneNumber,
      'count': count,
      'dateTime': dateTime?.toIso8601String(),
      'imageFilePath': imagePath,
      'recordFilePath': recordPath,
      'price': price,
    };
  }

  factory LocalQuickOrder.fromJson(Map<String, dynamic> json) =>
      LocalQuickOrder(
          id: json['id'],
          address: json['address'],
          inCity: json['inCity'] == 1 ? true : false,
          description: json['description'],
          phoneNumber: json['phoneNumber'],
          count: json['count'],
          dateTime: DateTime.tryParse(json['dateTime']),
          imagePath: json['imageFilePath'],
          recordPath: json['recordFilePath'],
          price: json['price']);

  String? get formattedTime {
    if (dateTime == null) return null;
    String formattedTime = DateFormat.jm().format(dateTime!);
    String am = "am".tr;
    String pm = "pm".tr;
    formattedTime = formattedTime.replaceAll("AM", am);
    formattedTime = formattedTime.replaceAll("PM", pm);
    return formattedTime;
  }

  String? get formattedDate {
    if (dateTime == null) return null;
    var dateFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = dateFormat.format(dateTime!);
    return formattedDate;
  }
}

extension QuickOrderExtension on QuickOrder {
  LocalQuickOrder toLocalQuickOrder() {
    return LocalQuickOrder(
        address: address,
        inCity: inCity,
        description: description,
        phoneNumber: phoneNumber,
        count: count,
        dateTime: dateTime,
        price: price,
        imagePath: imageFile?.path,
        recordPath: recordFile?.path);
  }
}

extension LocalQuickOrderExtension on LocalQuickOrder {
  QuickOrder toQuickOrder() {
    return QuickOrder(
        id: id.toString(),
        address: address,
        inCity: inCity,
        description: description,
        phoneNumber: phoneNumber,
        count: count,
        dateTime: dateTime,
        price: price,
        imageUrl: this.imagePath,
        audioUrl: recordPath,
        imageFile: this.imagePath != null ? File(this.imagePath!) : null,
        recordFile: recordPath != null ? File(recordPath!) : null);
  }
}