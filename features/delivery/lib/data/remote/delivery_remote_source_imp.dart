import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';
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
  Future<Result<List<QuickOrder>>> getAvailableQuickOrders() async {
    var response = await _deliveryApiService.getAvailableQuickOrders();
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
}
