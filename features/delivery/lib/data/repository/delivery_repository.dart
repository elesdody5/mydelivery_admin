import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_settings.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/review.dart';

abstract class DeliveryRepository {
  Future<Result<User>> getUserData();

  Future<Result<User>> getRemoteUserDetails(String deliveyId);

  Stream<List<ShopOrder>> getAvailableOrdersStream();

  Future<List<ShopOrder>> getAvailableOrders();

  Future<List<ShopOrder>> getWithDeliveryOrders();

  Future<List<ShopOrder>> getDeliveredOrders();

  Future<Result> addDeliveryToOrders(List<ShopOrder> orders);

  Future<Stream<List<ShopOrder>>> getCurrentDeliveryOrders(String userId);

  Future<List<ShopOrder>> getDeliveredOrdersForDelivery(String userId);

  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus);

  Future<Result<List<QuickOrder>>> getAvailableQuickOrders(String? version);

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

  Future<List<ShopOrder>> getAllOrders();

  Future<Result<List<QuickOrder>>> getAllDeliveredQuickOrders();

  Future<Result<List<QuickOrder>>> getAllWithDeliveryQuickOrders();

  Future<Result> updatedDeliveryBlockStates(String id, bool isBlocked);
  Future<Result> updatedDeliveryAdminBlockState(String id, bool isAdminBlocked);

  Future<Result> settleQuickOrders(
      List<String> ordersId,
      deliveryId,
      double totalOrderMoney,
      double profitPercent);

  Future<void> updateOrdersStatus(List<String> ordersId);

  Future<Result> removeQuickOrder(String? id);

  Future<Result<bool>> isAddressHidden(String deliveryId);

  Future<Result> updateAddressVisibilityState(String id, bool isHidden);

  Future<Result<OrderSettings>> getOrderSettings();

  Future<Result> updateDeliveryAccountBalance(
      String deliveryId, double accountBalance);

  Future<Result<List<QuickOrder>>> getDeliveryQuickOrderWithDebts(
      String? deliveryId);

  Future<Result> updateQuickOrderDebt(String? quickOrderId, double debt);
}
