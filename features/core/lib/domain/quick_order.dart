import 'dart:io';

import 'package:core/domain/user.dart';
import 'package:core/model/order_status.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class QuickOrder {
  String? id;
  String? address;
  bool? inCity;
  User? delivery;
  User? user;
  String? description;
  OrderStatus? orderStatus;
  String? phoneNumber;
  int? count;
  DateTime? dateTime;
  File? imageFile;
  String? imageUrl;

  QuickOrder(
      {this.id,
      this.address,
      this.inCity,
      this.delivery,
      this.user,
      this.description,
      this.orderStatus,
      this.phoneNumber,
      this.count,
      this.dateTime,
      this.imageUrl});

  factory QuickOrder.fromJson(Map<String, dynamic> json) => QuickOrder(
        id: json['_id'],
        address: json['address'],
        inCity: json["inCity"],
        delivery:
            json['delivery'] != null ? User.fromJson(json['delivery']) : null,
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        description: json['description'],
        orderStatus: stringToEnum(json['status']),
        phoneNumber: json['userPhone'],
        count: json['count'],
        imageUrl: json['photo'],
        dateTime: json["date"] != null ? DateTime.parse(json['date']) : null,
      );

  Future<Map<String, dynamic>> toJson() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      "_id": id,
      "address": address,
      "inCity": inCity,
      "delivery": delivery?.id,
      "user": user?.id,
      "description": description,
      "status": orderStatus?.enumToString(),
      "userPhone": phoneNumber,
      "count": count,
      "date": dateTime?.toIso8601String(),
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null
    };
  }

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
