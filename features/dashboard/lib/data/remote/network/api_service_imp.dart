import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/domain/model/notification_message.dart';

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
    final response = await _dio.get(userTypeUrl,
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

  @override
  Future<ApiResponse> sendQuickOrder(QuickOrder quickOrder) async {
    final response = await _dio.post(quickOrderUrl,
        queryParameters: {"userType": "delivery"}, data: quickOrder.toJson());
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> sendNotification(
      NotificationMessage notificationMessage) async {
    final response =
        await _dio.post(notificationUrl, data: notificationMessage.toJson());
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<Category>>> getAllCategory() async {
    final response = await _dio.get(categoriesUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Category> categories = [];
    response.data["categories"]
        .forEach((json) => categories.add(Category.fromJson(json)));
    categories.sort((first, second) =>
        first.name?.toLowerCase().compareTo(second.name?.toLowerCase() ?? "") ??
        0);
    return ApiResponse(responseData: categories);
  }

  @override
  Future<ApiResponse<List<Shop>>> getShopsByCategory(String categoryId) async {
    final response = await _dio
        .get(shopsByCategoryUrl, queryParameters: {"categoryId": categoryId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Shop> shops = [];
    response.data["shops"]?.forEach((json) => shops.add(Shop.fromJson(json)));
    shops.sort((first, second) =>
        first.name?.toLowerCase().compareTo(second.name?.toLowerCase() ?? "") ??
        0);

    return ApiResponse(responseData: shops);
  }

  @override
  Future<ApiResponse<List<Category>>> getShopSubCategory(String shopId) async {
    final response =
        await _dio.get(subCategoryUrl, queryParameters: {"shopId": shopId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Category> categories = [];
    response.data["subCategories"]
        .forEach((json) => categories.add(Category.fromJson(json)));
    return ApiResponse(responseData: categories);
  }

  @override
  Future<ApiResponse<Shop>> getShopById(String id) async {
    final response = await _dio.get(shopUrl, queryParameters: {"shopId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Shop shop = Shop.fromJson(response.data["shop"]);
    shop.isFavourite = response.data['isFavorite'];
    return ApiResponse(responseData: shop);
  }

  @override
  Future<ApiResponse<List<Product>>> getShopProducts(String shopId) async {
    final response =
        await _dio.get(productsUrl, queryParameters: {"shopId": shopId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Product> products = [];
    response.data["products"]
        .forEach((json) => products.add(Product.fromJson(json)));
    return ApiResponse(responseData: products);
  }

  @override
  Future<ApiResponse> removeUserById(String userId) async {
    final response =
        await _dio.delete(usersUrl, queryParameters: {"userId": userId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<List<NotificationMessage>>> getAllNotifications() async {
    final response = await _dio.get(
      notificationsUrl,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<NotificationMessage> notifications = [];
    response.data["notifications"].forEach(
        (json) => notifications.add(NotificationMessage.fromJson(json)));
    return ApiResponse(responseData: notifications);
  }

  @override
  Future<ApiResponse> deleteNotificationById(String id) async {
    final response = await _dio.delete(deleteNotificationsUrl,
        queryParameters: {"notificationId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }

    return ApiResponse(responseData: true);
  }
}
