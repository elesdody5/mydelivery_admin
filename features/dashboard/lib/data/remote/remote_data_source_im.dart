import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/category.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/remote/network/api_service.dart';
import 'package:dashboard/data/remote/remote_data_source.dart';
import 'package:dashboard/domain/model/notification_message.dart';

import 'network/api_service_imp.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSourceImp({ApiService? apiService})
      : _apiService = apiService ?? ApiServiceImp();

  Result<T> _getResultFromResponse<T>(ApiResponse apiResponse) {
    try {
      if (apiResponse.errorMessage != null) {
        return Error(ApiException(apiResponse.errorMessage!));
      } else if (apiResponse.networkError == true) {
        return Error(ApiException("networkError", networkError: true));
      } else {
        return Success(apiResponse.responseData);
      }
    } catch (error) {
      print("auth api error $error");
      return Error(ApiException("Something went wrong"));
    }
  }

  @override
  Future<Result<List<User>>> getAllUsers() async {
    var response = await _apiService.getAllUsers();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Offer>>> getAllOffers() async {
    var response = await _apiService.getAllOffers();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> deleteOffer(String offerId) async {
    var response = await _apiService.deleteOffer(offerId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> addOffer(Offer offer) async {
    var response = await _apiService.addOffer(offer);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Shop>>> getAllShops() async {
    var response = await _apiService.getAllShops();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) async {
    var response = await _apiService.sendQuickOrder(quickOrder);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> sendNotification(
      NotificationMessage notificationMessage) async {
    var response = await _apiService.sendNotification(notificationMessage);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Category>>> getAllCategory() async {
    var response = await _apiService.getAllCategory();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Shop>>> getShopsByCategory(String categoryId) async {
    var response = await _apiService.getShopsByCategory(categoryId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Shop>> getShopById(String id) async {
    var response = await _apiService.getShopById(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Category>>> getShopSubCategories(id) async {
    var response = await _apiService.getShopSubCategory(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Product>>> getShopProductsById(String shopId) async {
    var response = await _apiService.getShopProducts(shopId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeUserById(String userId) async {
    var response = await _apiService.removeUserById(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<NotificationMessage>>> getAllNotifications() async {
    var response = await _apiService.getAllNotifications();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> deleteNotificationById(String id) async {
    var response = await _apiService.deleteNotificationById(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> blockUser(String id, bool block) async {
    var response = await _apiService.blockUser(id, block);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeShopById(String id) async {
    var response = await _apiService.removeShopById(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateUserType(String userId, UserType userType) async {
    var response = await _apiService.updateUserType(userId, userType);
    return _getResultFromResponse(response);
  }
}
