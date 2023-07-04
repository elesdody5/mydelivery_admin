import 'package:core/domain/quick_order.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';

import 'api_service.dart';
import 'package:dio/dio.dart';
import 'package:core/data/remote/network_service.dart';

import 'apis_url.dart';

class ApiServiceImp implements ApiService {
  final Dio _dio;

  ApiServiceImp({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  @override
  Future<ApiResponse> addQuickOrder(QuickOrder quickOrder) async {
    try {
      final response = await _dio.post(quickOrderUrl,
          queryParameters: {"userType": "delivery"},
          data: FormData.fromMap(await quickOrder.toJson()));

      if (response.statusCode != 200 && response.statusCode != 201) {
        print("error message is ${response.data['message']}");
        return ApiResponse(errorMessage: response.data['message']);
      }

      String? id = response.data["createdElement"]?["_id"];
      if (quickOrder.recordFile != null) {
        await addAudioToQuickOrder(id, quickOrder);
      }

      return ApiResponse(responseData: true);
    } catch (e) {
      print(e);
      if (e is DioError) {
        return ApiResponse(networkError: true);
      }
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }

  Future<bool> addAudioToQuickOrder(String? id, QuickOrder quickOrder) async {
    final request = {"audio": await quickOrder.getRecordMultiPartFile()};
    final response = await _dio.post(recordsUrl,
        queryParameters: {"quickOrderId": id}, data: FormData.fromMap(request));

    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return false;
    }
    return true;
  }

  @override
  Future<ApiResponse<List<Shop>>> getAllShops() async {
    final response = await _dio.get(shopsUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Shop> shops = [];
    response.data["shops"].forEach((json) => shops.add(Shop.fromJson(json)));
    return ApiResponse(responseData: shops);
  }
  @override
  Future<ApiResponse> removeQuickOrder(String? id) async {
    final response = await _dio
        .delete(quickOrderUrl, queryParameters: {"quickOrderId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }
}
