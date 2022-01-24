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
  bool? isFavourite;
  Category? category;
  File? imageFile;

  Shop(
      {this.id,
      this.name,
      this.phone,
      this.imageUrl,
      this.address,
      this.latitude,
      this.longitude,
      this.isFavourite,
      this.openTime});

  factory Shop.fromJson(json) => Shop(
        id: json['_id'],
        name: json['name'],
        phone: json['phone'],
        imageUrl: json['photo'],
        address: json['fullAddress'],
        latitude: json['address']?['lattitude'],
        longitude: json['address']?['longitude'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "photo": imageUrl,
        'openTime': openTime,
        "fullAddress": address,
        "address": {'lattitude': latitude, "longitude": longitude}
      };

  Future<Map<String, dynamic>> toJsonWithImage() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      'openTime': openTime,
      "fullAddress": address,
      "address": {'lattitude': latitude, "longitude": longitude},
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null,
    };
  }
}
