import 'dart:ffi';

import 'package:core/domain/user.dart';

class Debt {
  String? id;
  User? userAdded;
  String? title;
  double? price;

  Debt({this.id, this.userAdded, this.title, this.price});

  factory Debt.fromJson(Map<String, dynamic> json, String id) => Debt(
      id: id,
      userAdded: User.fromJson(json["user"]),
      price: json["price"],
      title: json['title']);

  Map<String, dynamic> toJson() =>
      {"user": userAdded?.toJson(), "price": price, "title": title};
}
