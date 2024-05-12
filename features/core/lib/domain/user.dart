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
  int? totalOrders;
  num? totalOrdersMoney;
  num? accountBalance;

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
      this.totalOrders,
      this.accountBalance,
      this.totalOrdersMoney,
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
      accountBalance: json['accountBalance'],
      totalOrders: json['totalOrders'],
      totalOrdersMoney: json['totalOrdersMoney'],
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
      'totalOrders': totalOrders,
      'totalOrdersMoney': totalOrdersMoney,
      'accountBalance': accountBalance,
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
        "score": coins,
        'totalOrders': totalOrders,
        'totalOrdersMoney': totalOrdersMoney,
        'accountBalance': accountBalance,
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
          totalOrders == other.totalOrders &&
          totalOrdersMoney == other.totalOrdersMoney &&
          accountBalance == other.accountBalance &&
          imageUrl == other.imageUrl &&
          userType == other.userType;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      totalOrdersMoney.hashCode ^
      totalOrders.hashCode ^
      accountBalance.hashCode ^
      imageUrl.hashCode ^
      userType.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, address: $address, phone: $phone, imageUrl: $imageUrl, imageFile: $imageFile, userType: $userType, latitude: $latitude, longitude: $longitude, coins: $coins, isBlocked: $isBlocked, totalOrders: $totalOrders, totalOrdersMoney: $totalOrdersMoney, accountBalance: $accountBalance}';
  }
}
