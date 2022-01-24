import 'package:core/data/remote/network_service.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/response.dart';
import 'package:dio/dio.dart';

import '../apis_url/apis_url.dart';
import 'delivery_api_service.dart';

class DeliveryApiServiceImp implements DeliveryApiService {
  final Dio _dio;

  DeliveryApiServiceImp({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  @override
  Future<ApiResponse<User>> getUserById(String userId) async {
    final response =
        await _dio.get(userUrl, queryParameters: {"userId": userId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    User user = User.fromJson(response.data["user"]);
    return ApiResponse(responseData: user);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getAvailableQuickOrders() async {
    final response = await _dio.get(
      deliveryOrdersUrl,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['quickOrders']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
  }

  @override
  Future<ApiResponse> pickQuickOrder(
      String quickOrderId, String deliveryId) async {
    final response = await _dio.patch(quickOrdersUrl, queryParameters: {
      "quickOrderId": quickOrderId,
      "deliveryId": deliveryId
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getCurrentDeliveryQuickOrder(
      String deliveryId) async {
    final response = await _dio
        .get(deliveryOrdersUrl, queryParameters: {"deliveryId": deliveryId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['quickOrders']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(
        responseData: orders
            .where((order) => order.orderStatus != OrderStatus.delivered)
            .toList());
  }

  @override
  Future<ApiResponse> updateQuickOrderStatus(
      String quickOrderId, String status) async {
    final response = await _dio.patch(quickOrdersUrl, queryParameters: {
      "quickOrderId": quickOrderId,
    }, data: {
      "status": status
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getDeliveredQuickOrders(
      String deliveryId) async {
    final response = await _dio
        .get(deliveryOrdersUrl, queryParameters: {"deliveryId": deliveryId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['quickOrders']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(
        responseData: orders
            .where((order) => order.orderStatus == OrderStatus.delivered)
            .toList());
  }

  @override
  Future<ApiResponse<List<User>>> getAllDelivery() async {
    final response = await _dio.get(deliveryUrl,
        queryParameters: {"userType": UserType.delivery.enmToString()});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<User> deliveryList = [];
    response.data["users"].forEach((json) => deliveryList.add(User.fromJson(json)));
    return ApiResponse(responseData: deliveryList);
  }
}
