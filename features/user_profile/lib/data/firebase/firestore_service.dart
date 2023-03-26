import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

abstract class FireStoreService {
  Stream<List<ShopOrder>> getCurrentUserOrders(String userId);

  Future<List<ShopOrder>> getDeliveredOrdersForUser(String userId);

  Stream<List<ShopOrder>> getAvailableOrdersStream();

  Future<List<ShopOrder>> getAvailableOrders();

  Future<List<ShopOrder>> getDeliveredOrders();

  Future<Result> addUserToOrders(User User, List<ShopOrder> orders);

  Future<void> updateOrderStatus(OrderStatus orderStatus, String orderId);

  Future<void> removeOrders(List<String> ordersId);

  Future<int> getUserCoins(String userId);

  Future<List<ShopOrder>> getAllOrders();

  Future<void> updateOrdersStatus(List<String> ordersId);
}
