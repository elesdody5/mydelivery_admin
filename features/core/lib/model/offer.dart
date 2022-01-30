import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
class Offer {

  Offer({
    this.id,
    this.photo,
    this.description,
    this.shop,
  });

  String? id;
  String? photo;
  String? description;
  String? shop;
  File? imageFile;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["_id"],
        photo: json["photo"],
        description: json["description"],
        shop: json["shop"],
      );

  Future<Map<String, dynamic>> toJson() async {
    List<String>? mimeTypeData;
    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }

    Map<String, dynamic> json = {
      '_id': id,
      'description': description,
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
          filename: imageFile?.path.split('/').last ?? "",
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null,
    };
    return json;
  }
}
