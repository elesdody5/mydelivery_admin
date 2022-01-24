import 'package:core/domain/user.dart';
import 'package:core/model/order_status.dart';

class QuickOrder {
  String? id;
  String? address;
  bool? inCity;
  User? delivery;
  User? user;
  String? description;
  OrderStatus? orderStatus;

  QuickOrder(
      {this.id,
      this.address,
      this.inCity,
      this.delivery,
      this.user,
      this.description,
      this.orderStatus});

  factory QuickOrder.fromJson(Map<String, dynamic> json) => QuickOrder(
      id: json['_id'],
      address: json['address'],
      inCity: json["inCity"],
      delivery:
          json['delivery'] != null ? User.fromJson(json['delivery']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'],
      orderStatus: stringToEnum(json['status']));

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "address": address,
        "inCity": inCity,
        "delivery": delivery?.id,
        "user": user?.id,
        "description": description,
        "status": orderStatus?.enumToString()
      };
}
