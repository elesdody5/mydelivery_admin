import 'dart:io';

import 'package:core/model/category.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class Shop {
  String? id;
  String? name;
  String? phone;
  String? imageUrl;
  String? address;
  String? latitude;
  String? longitude;
  String? openTime;
  DateTime? startHour;
  DateTime? endHour;
  bool? isFavourite;
  Category? category;
  File? imageFile;

  Shop({
    this.id,
    this.name,
    this.phone,
    this.imageUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.isFavourite,
    this.openTime,
    this.startHour,
    this.endHour,
    this.category,
  });

  factory Shop.fromJson(json) {
    var openTime = json['opensAt'] as String?;
    List<String>? hours;
    if (openTime?.contains("/") == true) {
      hours = openTime?.split('/');
    }
    return Shop(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      imageUrl: json['photo'],
      address: json['fullAddress'],
      latitude: json['address']?['lattitude'],
      longitude: json['address']?['longitude'],
      category: json['category'] is String
          ? Category(id: json['category'])
          : Category.fromJson(json['category']),
      openTime: openTime,
      startHour: (hours?[0] != null || hours?.isNotEmpty == true)
          ? DateTime.parse(hours![0])
          : null,
      endHour: (hours?[1] != null || hours?.isNotEmpty == true)
          ? DateTime.parse(hours![1])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    if (startHour != null && endHour != null) {
      openTime = "$startHour/$endHour";
    }
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      "photo": imageUrl,
      'opensAt': openTime,
      "fullAddress": address,
      "category": category?.id,
      "address": {'lattitude': latitude, "longitude": longitude}
    };
  }

  Future<Map<String, dynamic>> toJsonWithImage() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    if (startHour != null && endHour != null) {
      openTime = "$startHour/$endHour";
    }
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      'opensAt': openTime,
      "fullAddress": address,
      "category": category?.id,
      "address": {'lattitude': latitude, "longitude": longitude},
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
          filename: imageFile?.path.split('/').last ?? "",
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null,
    };
  }

  bool? get isOpen {
    if (startHour?.hour == null || endHour?.hour == null) return null;
    int currentHour = DateTime.now().hour;
    if (currentHour < 12) currentHour += 24;
    int end = endHour!.hour;
    if (end < 12) end += 24;
    if (currentHour == startHour!.hour || currentHour == end) return true;
    return (currentHour > startHour!.hour) && (currentHour < end);
  }
}
