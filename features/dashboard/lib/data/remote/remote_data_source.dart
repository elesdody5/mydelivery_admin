import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/domain/model/notification_message.dart';

abstract class RemoteDataSource {
  Future<Result<List<User>>> getAllUsers();

  Future<Result<List<Offer>>> getAllOffers();

  Future<Result> deleteOffer(String offerId);

  Future<Result> addOffer(Offer offer);

  Future<Result<List<Shop>>> getAllShops();

  Future<Result> sendQuickOrder(QuickOrder quickOrder);

  Future<Result> sendNotification(NotificationMessage notificationMessage);

  Future<Result<List<Category>>> getAllCategory();

  Future<Result<List<Shop>>> getShopsByCategory(String categoryId);

  Future<Result<Shop>> getShopById(String id);

  Future<Result<List<Category>>> getShopSubCategories(id);

  Future<Result<List<Product>>> getShopProductsById(String shopId);

  Future<Result> removeUserById(String userId);

  Future<Result<List<NotificationMessage>>> getAllNotifications();
  Future<Result> deleteNotificationById(String id);
}
