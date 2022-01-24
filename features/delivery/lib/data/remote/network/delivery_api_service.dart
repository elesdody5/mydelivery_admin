import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/response.dart';

abstract class DeliveryApiService {
  Future<ApiResponse> getUserById(String userId);

  Future<ApiResponse<List<QuickOrder>>> getAvailableQuickOrders();

  Future<ApiResponse> pickQuickOrder(String quickOrderId, String deliveryId);

  Future<ApiResponse<List<QuickOrder>>> getCurrentDeliveryQuickOrder(
      String deliveryId);

  Future<ApiResponse> updateQuickOrderStatus(
      String quickOrderId, String status);

  Future<ApiResponse<List<QuickOrder>>> getDeliveredQuickOrders(
      String deliveryId);

  Future<ApiResponse<List<User>>> getAllDelivery();

  Future<ApiResponse>removeUserById(String id) ;
}
