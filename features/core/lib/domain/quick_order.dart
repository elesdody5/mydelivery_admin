import 'dart:io';

import 'package:core/domain/address.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order_status.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class QuickOrder {
  String? id;
  Address? address;
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
  String? audioUrl;
  File? recordFile;
  int? price;
  DateTime? deliveryPickedTime;

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
      this.imageUrl,
      this.audioUrl,
      this.deliveryPickedTime,
      this.price,
      this.recordFile,
      this.imageFile});

  factory QuickOrder.fromJson(Map<String, dynamic> json) => QuickOrder(
      id: json['_id'],
      address: Address.fromJson(json['address']),
      inCity: json["inCity"],
      delivery:
          json['delivery'] != null ? User.fromJson(json['delivery']) : null,
      user: (json['user'] != null && json['user'] is! String)
          ? User.fromJson(json['user'])
          : null,
      description: json['description'],
      orderStatus: stringToEnum(json['status']),
      phoneNumber: json['userPhone'],
      count: json['count'],
      imageUrl: json['photo'],
      audioUrl: json['audio'],
      dateTime: json["date"] != null ? DateTime.parse(json['date']) : null,
      deliveryPickedTime: json["withDeliveryTime"] != null
          ? DateTime.parse(json['withDeliveryTime'])
          : null,
      price: json['price']);

  Future<Map<String, dynamic>> toJson() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      "address": address?.toJson(),
      "inCity": inCity,
      "delivery": delivery?.id,
      "user": user?.id,
      "description": description,
      "status": orderStatus?.enumToString(),
      "userPhone": phoneNumber,
      "count": count,
      "date": dateTime?.toIso8601String(),
      "price": price,
      "withDeliveryTime": deliveryPickedTime?.toIso8601String(),
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null
    };
  }

  Future<MultipartFile> getRecordMultiPartFile() async {
    List<String>? mimeTypeData;

    if (recordFile != null) {
      mimeTypeData = lookupMimeType(recordFile!.path)?.split('/');
    }
    return MultipartFile.fromFile(recordFile!.path,
        filename: recordFile?.path.split('/').last ?? "",
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
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
