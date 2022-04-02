import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:flutter/cupertino.dart';

abstract class VendorRepository {
  Future<Result<List<Shop>>> getVendorShops();

  Future<Result<List<Category>>> getShopSubCategories(String shopId);

  Future<Result<List<Product>>> getShopProducts(String shopId);

  Future<Result> removeProduct(String id);

  Future<Result<Category>> addSubCategory(String id, String subCategory);

  Future<Result<Product>> updateProduct(Product product);

  Future<Result<Product>> addProduct(Product product);

  Future<Result<Shop>> getShopById(String shopId);

  Future<Result<Shop>> updateShop(Shop shop);

  Future<Result<Shop>> addShop(Shop shop);

  Future<Result<List<Category>>> getAllCategory();

  Future<Result<User>> getUserData();

  Future<Stream<List<Order>>> getShopOrders();

  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus);

  Future<List<Order>> getShopDelivered();

  Future<Result> removeSubCategory(String id);

  Future<Result> sendQuickOrder(QuickOrder quickOrder);

  Future<Result> removeShop(String shopId);

  Future<Result<List<User>>> getAllVendors();

  Future<void> saveCurrentUserId(String id);

  Future<Result> removeUserById(String id);

  Future<Result<List<QuickOrder>>> getQuickOrderByUserId();
}
