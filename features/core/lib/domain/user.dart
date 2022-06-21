import 'dart:io';

import 'package:core/domain/user_type.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class User {
  String? id;
  String? name;
  String? address;
  String? phone;
  String? imageUrl;
  File? imageFile;
  UserType? userType;
  String? latitude;
  String? longitude;
  int? coins;
  bool isBlocked;

  User(
      {this.userType,
      this.name,
      this.id,
      this.phone,
      this.address,
      this.imageUrl,
      this.latitude,
      this.longitude,
      this.imageFile,
      this.coins,
      this.isBlocked = false});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"],
      name: json['username'],
      phone: json['phone'],
      imageUrl: json['photo'],
      address: json['fullAddress'],
      latitude: json["address"]?["lattitude"],
      longitude: json["address"]?["longitude"],
      userType: stringToEnum(json['userType']?.toLowerCase()),
      coins: json['score'],
      isBlocked: json['blocked'] ?? false);

  Future<Map<String, dynamic>> toJsonWithImage() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      '_id': id,
      'username': name,
      'phone': phone,
      'userType': userType?.enmToString(),
      "fullAddress": address,
      "address": {'lattitude': latitude, "longitude": longitude},
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null,
    };
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': name,
        'phone': phone,
        'userType': userType?.enmToString(),
        "fullAddress": address,
        "address": {'lattitude': latitude, "longitude": longitude},
        "photo": imageUrl,
        "score": coins
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          phone == other.phone &&
          imageUrl == other.imageUrl &&
          userType == other.userType;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      imageUrl.hashCode ^
      userType.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, address: $address, phone: $phone, imageUrl: $imageUrl, userType: $userType}';
  }
}
