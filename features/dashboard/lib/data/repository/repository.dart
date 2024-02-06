import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:core/domain/city.dart';
import 'package:dashboard/domain/model/debt.dart';
import 'package:dashboard/domain/model/notification_message.dart';
import 'package:core/model/order_settings.dart';

abstract class Repository {
  Future<Result<List<User>>> getAllUsers();

  Future<void> saveCurrentUserId(String id);

  Future<Result<List<Offer>>> getOffers();

  Future<Result> deleteOffer(String offerId);

  Future<Result> addOffer(Offer offer);

  Future<Result<List<Shop>>> getAllShops();

  Future<Result<List<Category>>> getAllCategory();

  Future<Result<OrderSettings>> getOrderSettings();

  Future<Result> updateOrderSettings(OrderSettings orderSettings);

  Future<Result> sendQuickOrder(QuickOrder quickOrder);

  Future<Result> sendNotification(NotificationMessage notificationMessage);

  Future<Result<List<Shop>>> getShopsByCategory(String categoryId);

  Future<Result<Shop>> getShopById(String id);

  Future<Result<List<Category>>> getShopSubCategories(String shopId);

  Future<Result<List<Product>>> getShopProducts(String shopId);

  Future<Result> removeUserById(String userId);

  Future<Result<List<NotificationMessage>>> getAllNotifications();

  Future<Result> deleteNotificationById(String id);

  Future<Result> blockUser(String id, bool block);

  Future<Result> removeShopById(String id);

  Future<void> logout();

  Future<Result<List<City>>> getCities();

  Future<Result> addNewCity(City city);

  Future<Result> addDebts(Debt debt);

  Future<Result> updateCity(City currentCity);

  Future<Result> updateUserType(String userId, UserType userType);

  Future<Result<List<Debt>>> getAllDebts();

  Future<Result>removeDebt(String? id);
}
