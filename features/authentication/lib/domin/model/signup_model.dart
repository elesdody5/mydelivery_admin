import 'dart:io';

import 'package:core/domain/user_type.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class SignUpModel {
  String? name;
  String? password;
  String? confirmPassword;
  String? phone;

  UserType? userType;

  double? latitude;
  double? longitude;
  String? address;

  File? imageFile;

  SignUpModel(
      {this.name,
      this.password,
      this.confirmPassword,
      this.phone,
      this.latitude,
      this.longitude,
      this.address,
      this.imageFile,
      this.userType});

  Future<Map<String, dynamic>> toJson() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      "username": name,
      "password": password,
      "passwordConfirm": confirmPassword,
      "userType": userType?.enmToString(),
      "phone": phone,
      "fullAddress": address,
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null
    };
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    var signUPModel = SignUpModel(
      name: json["username"],
      userType: stringToEnum(json["userType"]),
      phone: json["phone"],
    );

    return signUPModel;
  }
}
