import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class FireStoreService {
  Stream<List<ShopOrder>> getCurrentDeliveryOrders(String deliveryId);

  Future<List<ShopOrder>> getDeliveredOrdersForDelivery(String deliveryId);

  Stream<List<ShopOrder>> getAvailableOrdersStream();

  Future<List<ShopOrder>> getAvailableOrders();

  Future<List<ShopOrder>> getDeliveredOrders();

  Future<List<ShopOrder>> getWithDeliveryOrders();

  Future<Result> addDeliveryToOrders(User delivery, List<ShopOrder> orders);

  Future<void> updateOrderStatus(OrderStatus orderStatus, String orderId);

  Future<void> removeOrders(List<String> ordersId);

  Future<int> getDeliveryCoins(String deliveryId);

  Future<List<ShopOrder>> getAllOrders();

  Future<void> updateOrdersStatus(List<String> ordersId);
}
