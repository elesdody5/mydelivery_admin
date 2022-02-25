import 'package:core/domain/user.dart';
import 'package:core/model/cart_item.dart';
import 'package:core/model/shop.dart';
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

  Order(
      {this.id,
      this.user,
      this.dateTime,
      this.status,
      this.delivery,
      this.shop,
      this.deliveryPrice,
      List<CartItem>? cartItems})
      : _cartItems = cartItems ?? [];

  Map<String, dynamic> toJson() => {
        "cartItems": _cartItems?.map((e) => e.toJson()).toList(),
        "time": dateTime?.toIso8601String(),
        "orderStatus": status?.enumToString(),
        "delivery": delivery?.toJson(),
        "shop": shop?.toJson(),
        "deliveryPrice": deliveryPrice,
        "user": user?.toJson()
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
      delivery:
          json?['delivery'] != null ? User.fromJson(json?['delivery']) : null,
      deliveryPrice: json?['deliveryPrice'],
      status: stringToEnum(json?['orderStatus']),
      user: User.fromJson(json?['user']));

  @override
  String toString() {
    return 'Order{id: $id, userId: $user, deliveryPrice: $deliveryPrice, products: $cartItems, dateTime: $dateTime, status: $status, delivery: $delivery, shop: $shop}';
  }

  String? get formattedDate {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm a");
    if (dateTime == null) return null;
    return dateFormat.format(dateTime!);
  }
}
