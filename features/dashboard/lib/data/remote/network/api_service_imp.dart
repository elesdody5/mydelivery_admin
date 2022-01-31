import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/offer.dart';
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
  @override
  Future<ApiResponse<List<User>>> getAllUsers() async {
    final response = await _dio.get(usersUrl,
        queryParameters: {"userType": UserType.user.enmToString()});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<User> usersList = [];
    response.data["users"]
        .forEach((json) => usersList.add(User.fromJson(json)));
    return ApiResponse(responseData: usersList);
  }

  @override
  Future<ApiResponse<List<Offer>>> getAllOffers() async {
    final response = await _dio.get(offersUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Offer> offers = [];
    response.data["offers"].forEach((json) => offers.add(Offer.fromJson(json)));
    return ApiResponse(responseData: offers);
  }

  @override
  Future<ApiResponse> deleteOffer(String offerId) async {
    final response =
        await _dio.delete(offerUrl, queryParameters: {"offerId": offerId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> addOffer(Offer offer) async {
    final response = await _dio.post(offerUrl,
        data: FormData.fromMap(await offer.toJson()),
        queryParameters: {"shopId": offer.shop});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
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
}
