import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/review.dart';

abstract class DeliveryRepository {
  Future<Result<User>> getUserData();

  Stream<List<Order>> getAvailableOrders();

  Future<Result> addDeliveryToOrders(List<Order> orders);

  Future<Stream<List<Order>>> getCurrentDeliveryOrders(String userId);

  Future<List<Order>> getDeliveredOrdersForDelivery(String userId);

  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus);

  Future<Result<List<QuickOrder>>> getAvailableQuickOrders();

  Future<Result> pickQuickOrder(String quickOrderId);

  Future<Result<List<QuickOrder>>> getCurrentDeliveryQuickOrders(String userId);

  Future<Result> updateQuickOrderStatus(String quickOrderId, String status);

  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(String userId);

  Future<Result<List<User>>> getAllDelivery();

  Future<void> saveCurrentUserId(String id);

  Future<Result> removeUserById(String id);

  Future<void> removeDeliveryOrders(List<String> ordersId);

  Future<void> removeDeliveryQuickOrders(List<String> ordersId);

  Future<Result<List<Review>>> getAllDeliveryReviews(String deliveryId);

  Future<int> getDeliveryCoins(String deliveryId);
}
