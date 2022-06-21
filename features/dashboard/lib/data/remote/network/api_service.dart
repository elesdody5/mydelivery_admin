import 'package:core/domain/quick_order.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/domain/model/notification_message.dart';

abstract class ApiService {
  Future<ApiResponse> getAllUsers();

  Future<ApiResponse<List<Offer>>> getAllOffers();

  Future<ApiResponse> deleteOffer(String offerId);

  Future<ApiResponse> addOffer(Offer offer);

  Future<ApiResponse<List<Shop>>> getAllShops();

  Future<ApiResponse> sendQuickOrder(QuickOrder quickOrder);

  Future<ApiResponse> sendNotification(NotificationMessage notificationMessage);

  Future<ApiResponse<List<Category>>> getAllCategory();

  Future<ApiResponse<List<Shop>>> getShopsByCategory(String categoryId);

  Future<ApiResponse<List<Category>>> getShopSubCategory(String shopId);

  Future<ApiResponse<Shop>> getShopById(String id);

  Future<ApiResponse<List<Product>>> getShopProducts(String shopId);

  Future<ApiResponse> removeUserById(String userId);

  Future<ApiResponse<List<NotificationMessage>>> getAllNotifications();

  Future<ApiResponse> deleteNotificationById(String id);

  Future<ApiResponse> blockUser(String id,bool block) ;
}
