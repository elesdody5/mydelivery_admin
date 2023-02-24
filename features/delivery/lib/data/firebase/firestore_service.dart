import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class FireStoreService {
  Stream<List<Order>> getCurrentDeliveryOrders(String deliveryId);

  Future<List<Order>> getDeliveredOrdersForDelivery(String deliveryId);

  Stream<List<Order>> getAvailableOrdersStream();

  Future<List<Order>> getAvailableOrders();

  Future<List<Order>> getDeliveredOrders();

  Future<List<Order>> getWithDeliveryOrders();

  Future<Result> addDeliveryToOrders(User delivery, List<Order> orders);

  Future<void> updateOrderStatus(OrderStatus orderStatus, String orderId);

  Future<void> removeOrders(List<String> ordersId);

  Future<int> getDeliveryCoins(String deliveryId);

  Future<List<Order>> getAllOrders();

  Future<void> updateOrdersStatus(List<String> ordersId);
}
