import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';
import 'package:core/model/review.dart';
import 'package:delivery/data/remote/network/delivery_api_service.dart';
import 'package:delivery/data/remote/network/delivery_api_service_imp.dart';

import 'delivery_remote_data_source.dart';

class DeliveryRemoteDataSourceImp implements DeliveryRemoteDataSource {
  final DeliveryApiService _deliveryApiService;

  DeliveryRemoteDataSourceImp({DeliveryApiService? deliveryApiService})
      : _deliveryApiService = deliveryApiService ?? DeliveryApiServiceImp();

  Result<T> _getResultFromResponse<T>(ApiResponse apiResponse) {
    try {
      if (apiResponse.errorMessage != null) {
        return Error(ApiException(apiResponse.errorMessage!));
      } else {
        return Success(apiResponse.responseData);
      }
    } catch (error) {
      print("auth api error $error");
      return Error(ApiException("Something went wrong"));
    }
  }

  @override
  Future<Result<List<QuickOrder>>> getAvailableQuickOrders(
      String? version) async {
    var response = await _deliveryApiService.getAvailableQuickOrders(version);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<User>> getUserById(String userId) async {
    var response = await _deliveryApiService.getUserById(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> pickQuickOrder(String quickOrderId, String deliveryId) async {
    var response =
        await _deliveryApiService.pickQuickOrder(quickOrderId, deliveryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getCurrentDeliveryQuickOrder(
      String deliveryId) async {
    var response =
        await _deliveryApiService.getCurrentDeliveryQuickOrder(deliveryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateQuickOrderStatus(
      String quickOrderId, String status) async {
    var response =
        await _deliveryApiService.updateQuickOrderStatus(quickOrderId, status);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(
      String deliveryId) async {
    var response =
        await _deliveryApiService.getDeliveredQuickOrders(deliveryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<User>>> getAllDelivery() async {
    var response = await _deliveryApiService.getAllDelivery();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeUserById(String id) async {
    var response = await _deliveryApiService.removeUserById(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeQuickOrders(List<String> ordersId) async {
    var response = await _deliveryApiService.removeQuickOrders(ordersId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Review>>> getAllDeliveryReviews(String deliveryId) async {
    var response = await _deliveryApiService.getAllDeliveryReviews(deliveryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getAllQuickOrders() async {
    var response = await _deliveryApiService.getAllQuickOrders();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getAllDeliveredQuickOrders() async {
    var response = await _deliveryApiService.getAllDeliveredQuickOrders();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getAllWithDeliveryQuickOrders() async {
    var response = await _deliveryApiService.getAllWithDeliveryQuickOrders();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateDeliveryBlockStates(String id, bool isBlocked) async {
    var response =
        await _deliveryApiService.updateDeliveryBlockStates(id, isBlocked);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<User>> updateQuickOrdersStatusToDone(
      List<String> ordersId,
      String deliveryId,
      int totalOrders,
      double ordersMoney,
      double profitPercent) async {
    var response = await _deliveryApiService.updateOrders(
        ordersId, deliveryId, totalOrders, ordersMoney, profitPercent);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeQuickOrder(String? id) async {
    var response = await _deliveryApiService.removeQuickOrder(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateDeliveryAccountBalance(
      String deliveryId, double accountBalance) async {
    var response = await _deliveryApiService.updateDeliveryAccountBalance(
        deliveryId, accountBalance);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getDeliveryQuickOrdersWithDebts(
      String deliveryId) async {
    var response =
        await _deliveryApiService.getDeliveryQuickOrdersWithDebts(deliveryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateQuickOrderDebt(String? quickOrderId, double debt) async {
    var response =
        await _deliveryApiService.updateQuickOrderDebt(quickOrderId, debt);
    return _getResultFromResponse(response);
  }
}
