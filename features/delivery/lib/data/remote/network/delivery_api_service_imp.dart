import 'package:core/data/remote/network_service.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/response.dart';
import 'package:core/model/review.dart';
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
  Future<ApiResponse<List<QuickOrder>>> getAvailableQuickOrders(
      String? version) async {
    final response = await _dio
        .get(deliveryOrdersUrl, queryParameters: {"version": version});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders.toList());
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
    final response = await _dio.get(deliveryOrdersUrl, queryParameters: {
      "deliveryId": deliveryId,
      "status": OrderStatus.withDelivery.enumToString()
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
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
    final response = await _dio.get(deliveryOrdersUrl, queryParameters: {
      "deliveryId": deliveryId,
      "status": OrderStatus.delivered.enumToString()
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getAllWithDeliveryQuickOrders() async {
    final response = await _dio.get("$quickOrdersUrl/status",
        queryParameters: {"status": OrderStatus.withDelivery.enumToString()});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders.reversed.toList());
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getAllDeliveredQuickOrders() async {
    final response = await _dio.get("$quickOrdersUrl/status",
        queryParameters: {"status": OrderStatus.delivered.enumToString()});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
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
    response.data["users"]
        .forEach((json) => deliveryList.add(User.fromJson(json)));
    return ApiResponse(responseData: deliveryList);
  }

  @override
  Future<ApiResponse> removeUserById(String id) async {
    final response =
        await _dio.delete(userUrl, queryParameters: {"userId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> removeQuickOrders(List<String> ordersId) async {
    final response =
        await _dio.delete(deleteQuickOrders, data: {"quickOrders": ordersId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<Review>>> getAllDeliveryReviews(
      String deliveryId) async {
    final response =
        await _dio.get(reviewsUrl, queryParameters: {"deliveryId": deliveryId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Review> reviews = [];
    response.data["review"]
        .forEach((json) => reviews.add(Review.fromJson(json)));
    return ApiResponse(responseData: reviews);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getAllQuickOrders() async {
    final response = await _dio.get(quickOrdersUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
  }

  @override
  Future<ApiResponse> updateDeliveryBlockStates(
      String id, bool isBlocked) async {
    final response = await _dio.patch(userUrl,
        queryParameters: {"userId": id}, data: {"blocked": isBlocked});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<User>> settleQuickOrders(
      String currentUserId,
      List<String> ordersId,
      String deliveryId,
      double totalOrdersMoney,
      double profitPercent) async {
    final response = await _dio.post(settleQuickOrdersUrl, queryParameters: {
      "deliveryId": deliveryId,
      "ordersTotalMoney": totalOrdersMoney,
      "profit": profitPercent,
      "userAddedId": currentUserId
    }, data: {
      "quickOrders": ordersId
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: User.fromJson(response.data['user']));
  }

  @override
  Future<ApiResponse> removeQuickOrder(String? id) async {
    final response = await _dio
        .delete(quickOrdersUrl, queryParameters: {"quickOrderId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> updateDeliveryAccountBalance(
      String? deliveryId, double accountBalance) async {
    final response = await _dio.patch(userUrl, queryParameters: {
      "userId": deliveryId,
    }, data: {
      "accountBalance": accountBalance
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<QuickOrder>>> getDeliveryQuickOrdersWithDebts(
      String? deliveryId) async {
    final queryParameters =
        deliveryId != null ? {"deliveryId": deliveryId} : null;

    final response = await _dio.get(quickOrdersWithDebtsUrl,
        queryParameters: queryParameters);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<QuickOrder> orders = [];
    response.data['data']
        .forEach((json) => orders.add(QuickOrder.fromJson(json)));
    return ApiResponse(responseData: orders);
  }

  @override
  Future<ApiResponse> updateQuickOrderDebt(
      String? quickOrderId, double debt) async {
    final response = await _dio.patch(quickOrdersUrl, queryParameters: {
      "quickOrderId": quickOrderId,
    }, data: {
      "debt": debt
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }

  @override
  updatedDeliveryAdminBlockState(String id, bool isAdminBlocked) async {
    final response = await _dio.patch(userUrl,
        queryParameters: {"userId": id},
        data: {"adminBlocked": isAdminBlocked});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }
}
