import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class FireStoreService {
  Stream<List<Order>> getAvailableShopOrders(String shopId);

  Future<List<Order>> getDeliveredOrdersForShop(String shopId);

  Future<void> updateOrderStatus(OrderStatus orderStatus, String orderId);
}
