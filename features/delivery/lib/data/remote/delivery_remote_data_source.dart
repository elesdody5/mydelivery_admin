import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/review.dart';

abstract class DeliveryRemoteDataSource {
  Future<Result<User>> getUserById(String userId);

  Future<Result<List<QuickOrder>>> getAvailableQuickOrders();

  Future<Result> pickQuickOrder(String quickOrderId, String deliveryId);

  Future<Result<List<QuickOrder>>> getCurrentDeliveryQuickOrder(
      String deliveryId);

  Future<Result> updateQuickOrderStatus(String quickOrderId, String status);

  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(String deliveryId);

  Future<Result<List<User>>> getAllDelivery();

  Future<Result> removeUserById(String id);

  Future<void> removeQuickOrders(List<String> ordersId) ;

  Future<Result<List<Review>>> getAllDeliveryReviews(String deliveryId);
}
