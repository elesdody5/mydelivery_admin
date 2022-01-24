import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class DeliveryRepository {
  Future<Result<User>> getUserData();

  Stream<List<Order>> getAvailableOrders();

  Future<Result> addDeliveryToOrders(List<Order> orders);

  Future<Stream<List<Order>>> getCurrentDeliveryOrders();

  Future<List<Order>> getDeliveredOrdersForDelivery();

  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus);

  Future<Result<List<QuickOrder>>> getAvailableQuickOrders();

  Future<Result> pickQuickOrder(String quickOrderId);

  Future<Result<List<QuickOrder>>> getCurrentDeliveryQuickOrders();

  Future<Result> updateQuickOrderStatus(String quickOrderId, String status);

  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders();

  Future<Result<List<User>>> getAllDelivery();

  Future<void> saveCurrentUserId(String id);

  Future<Result> removeUserById(String id);
}
