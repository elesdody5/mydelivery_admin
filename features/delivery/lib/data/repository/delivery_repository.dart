import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/review.dart';

abstract class DeliveryRepository {
  Future<Result<User>> getUserData();

  Future<Result<User>> getRemoteUserDetails(String deliveyId);

  Stream<List<Order>> getAvailableOrdersStream();

  Future<List<Order>> getAvailableOrders();

  Future<List<Order>> getWithDeliveryOrders();

  Future<List<Order>> getDeliveredOrders();

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

  Future<Result<List<QuickOrder>>> getAllQuickOrders();

  Future<List<Order>> getAllOrders();

  Future<Result<List<QuickOrder>>> getAllDeliveredQuickOrders();

  Future<Result<List<QuickOrder>>> getAllWithDeliveryQuickOrders();

  Future<Result> updatedDeliveryBlockStates(String id, bool isBlocked);

  Future<Result> updateOrdersStatus(List<String> ordersId) ;
}
