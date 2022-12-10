import 'package:core/domain/user.dart';
import 'package:core/model/cart_item.dart';
import 'package:core/model/shop.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'order_status.dart';

class Order {
  String? id;
  int? deliveryPrice;
  List<CartItem>? _cartItems;
  DateTime? dateTime;
  OrderStatus? status;
  User? delivery;
  User? user;
  Shop? shop;
  int? coins;
  String? imageUrl;
  String? audioUrl;

  Order(
      {this.id,
        this.user,
        this.dateTime,
        this.status,
        this.delivery,
        this.shop,
        this.deliveryPrice,
        this.coins,
        this.imageUrl,
        this.audioUrl,
        List<CartItem>? cartItems})
      : _cartItems = cartItems ?? [];

  Map<String, dynamic> toJson() =>
      {
        "cartItems": _cartItems?.map((e) => e.toJson()).toList(),
        "time": dateTime?.toIso8601String(),
        "orderStatus": status?.enumToString() ??
            OrderStatus.waitingShopResponse.enumToString(),
        "delivery": delivery?.toJson(),
        "shop": shop?.toJson(),
        "deliveryPrice": deliveryPrice,
        "user": user?.toJson(),
        "coins": coins,
        "audio": audioUrl,
        "image": imageUrl
      };

  List<CartItem>? get cartItems => _cartItems;

  double get price {
    double totalPrice = 0.0;
    _cartItems?.forEach((element) {
      totalPrice += element.price;
    });
    return totalPrice;
  }

  factory Order.fromJson(Map<String, dynamic>? json, String id) => Order(
      id: id,
      dateTime: json?["time"] != null ? DateTime.parse(json?['time']) : null,
      cartItems: List<CartItem>.from(
          json?['cartItems']?.map((cartItem) => CartItem.fromJson(cartItem))),
      shop: Shop.fromJson(json?['shop']),
      coins: json?['coins'],
      audioUrl: json?['audio'],
      imageUrl: json?['image'],
      delivery:
      json?['delivery'] != null ? User.fromJson(json?['delivery']) : null,
      deliveryPrice: json?['deliveryPrice'],
      status: stringToEnum(json?['orderStatus']),
      user: User.fromJson(json?['user']));

  @override
  String toString() {
    return 'Order{id: $id, userId: $user, deliveryPrice: $deliveryPrice, products: $cartItems, dateTime: $dateTime, status: $status, delivery: $delivery, shop: $shop}';
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
