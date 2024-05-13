import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/response.dart';
import 'package:core/model/review.dart';

abstract class DeliveryApiService {
  Future<ApiResponse> getUserById(String userId);

  Future<ApiResponse<List<QuickOrder>>> getAvailableQuickOrders(
      String? version);

  Future<ApiResponse> pickQuickOrder(String quickOrderId, String deliveryId);

  Future<ApiResponse<List<QuickOrder>>> getCurrentDeliveryQuickOrder(
      String deliveryId);

  Future<ApiResponse> updateQuickOrderStatus(
      String quickOrderId, String status);

  Future<ApiResponse<List<QuickOrder>>> getDeliveredQuickOrders(
      String deliveryId);

  Future<ApiResponse<List<QuickOrder>>> getAllDeliveredQuickOrders();

  Future<ApiResponse<List<QuickOrder>>> getAllWithDeliveryQuickOrders();

  Future<ApiResponse<List<User>>> getAllDelivery();

  Future<ApiResponse> removeUserById(String id);

  Future<ApiResponse> removeQuickOrders(List<String> ordersId);

  Future<ApiResponse<List<Review>>> getAllDeliveryReviews(String deliveryId);

  Future<ApiResponse<List<QuickOrder>>> getAllQuickOrders();

  Future<ApiResponse> updateDeliveryBlockStates(String id, bool isBlocked);

  Future<ApiResponse<User>> updateOrders(
      List<String> ordersId,
      String deliveryId,
      int totalOrders,
      double totalOrdersMoney,
      double profitPercent);

  Future<ApiResponse> removeQuickOrder(String? id);

  Future<ApiResponse> updateDeliveryAccountBalance(String? deliveryId,double accountBalance);
}
