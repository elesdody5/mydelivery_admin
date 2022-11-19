import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class FireStoreService {
  Stream<List<Order>> getCurrentDeliveryOrders(String deliveryId);

  Future<List<Order>> getDeliveredOrdersForDelivery(String deliveryId);

  Stream<List<Order>> getAvailableOrders();

  Future<Result> addDeliveryToOrders(User delivery, List<Order> orders);

  Future<void> updateOrderStatus(OrderStatus orderStatus, String orderId);

  Future<void> removeOrdersIds(List<String> ordersId);

  Future<int> getDeliveryCoins(String deliveryId);
}
