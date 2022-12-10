import 'dart:io';

import 'package:core/model/cart_item.dart';
import 'package:core/model/shop.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class Product {
  String? id;
  String? shopId;
  String? name;
  String? image;
  String? subCategoryId;
  num? price = 0;
  String? description;
  File? imageFile;

  Product({
    this.id,
    this.shopId,
    this.name,
    this.image,
    this.subCategoryId,
    this.price,
    this.description,
  });

  factory Product.fromJson(json) => Product(
      id: json["_id"],
      name: json['name'],
      image: json["photo"],
      shopId: json['shop'],
      subCategoryId: json['subCategory'],
      price: json['price']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        'name': name,
        "photo": image,
        'subCategory': subCategoryId,
        'price': price,
        'shop': shopId,
        'description': description
      };

  Future<Map<String, dynamic>> toJsonWithImage() async {
    List<String>? mimeTypeData;

    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path)?.split('/');
    }
    return {
      "_id": id,
      'name': name,
      'subCategory': subCategoryId,
      'price': price,
      'description': description,
      'shop': shopId,
      "photo": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile?.path.split('/').last ?? "",
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1]))
          : null,
    };
  }
}

extension ProductItemConvertion on List<Product> {
  List<CartItem> toCartItem(Shop shop) {
    return map((product) => CartItem(
      product: product,
      shop: shop,
    )).toList();
  }
}
