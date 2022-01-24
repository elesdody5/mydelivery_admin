import 'dart:convert';

import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';

import '../const.dart';

class CartItem {
  int? id;
  String? userId;
  Product? product;
  Shop? shop;
  int quantity;

  CartItem({
    this.id,
    this.userId,
    this.product,
    this.shop,
    this.quantity = 0,
  });

  factory CartItem.fromJson(Map<String, dynamic> cartJson) {
    return CartItem(
      id: cartJson[cartItemId],
      userId: cartJson[cartItemuserId],
      product: Product.fromJson(json.decode(cartJson[cartItemProduct])),
      shop: Shop.fromJson(json.decode(cartJson[cartItemShop])),
      quantity: cartJson[cartItemQuantity],
    );
  }

  Map<String, dynamic> toJson() => {
        cartItemId: id,
        cartItemuserId: userId,
        cartItemQuantity: quantity,
        cartItemProduct: json.encode(product?.toJson()),
        cartItemShop: json.encode(shop?.toJson())
      };

  CartItem copy({
    int? id,
    String? userId,
    Product? product,
    Shop? shop,
    int? quantity,
    double? price,
  }) =>
      CartItem(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          product: product ?? this.product,
          shop: shop ?? this.shop,
          quantity: quantity ?? this.quantity);

  num get price => (quantity) * (product?.price ?? 0);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          product == other.product &&
          shop == other.shop &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      product.hashCode ^
      shop.hashCode ^
      quantity.hashCode;
}
