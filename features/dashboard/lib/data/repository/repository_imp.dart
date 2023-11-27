import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/city.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/firebase/firestore_service.dart';
import 'package:dashboard/data/firebase/firestore_service_imp.dart';
import 'package:dashboard/data/remote/remote_data_source.dart';
import 'package:dashboard/data/remote/remote_data_source_im.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/domain/model/notification_message.dart';
import 'package:core/model/order_settings.dart';

class MainRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final SharedPreferencesManager _sharedPreferencesManager;
  final FireStoreService _fireStoreService;

  MainRepository(
      {RemoteDataSource? remoteDataSource,
      SharedPreferencesManager? sharedPreferencesManager,
      FireStoreService? fireStoreService})
      : _remoteDataSource = remoteDataSource ?? RemoteDataSourceImp(),
        _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp(),
        _fireStoreService = fireStoreService ?? FireStoreServiceImp();

  @override
  Future<Result<List<User>>> getAllUsers() {
    return _remoteDataSource.getAllUsers();
  }

  @override
  Future<void> saveCurrentUserId(String id) async {
    await _sharedPreferencesManager.saveUserId(id);
  }

  @override
  Future<Result<List<Offer>>> getOffers() {
    return _remoteDataSource.getAllOffers();
  }

  @override
  Future<Result> deleteOffer(String offerId) {
    return _remoteDataSource.deleteOffer(offerId);
  }

  @override
  Future<Result> addOffer(Offer offer) {
    return _remoteDataSource.addOffer(offer);
  }

  @override
  Future<Result<List<Shop>>> getAllShops() {
    return _remoteDataSource.getAllShops();
  }

  @override
  Future<Result<List<Category>>> getAllCategory() {
    return _remoteDataSource.getAllCategory();
  }

  @override
  Future<Result<OrderSettings>> getOrderSettings() {
    return _fireStoreService.getOrderSettings();
  }

  @override
  Future<Result> updateOrderSettings(OrderSettings orderSettings) {
    return _fireStoreService.updateOrderSettings(orderSettings);
  }

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) {
    return _remoteDataSource.sendQuickOrder(quickOrder);
  }

  @override
  Future<Result> sendNotification(NotificationMessage notificationMessage) {
    return _remoteDataSource.sendNotification(notificationMessage);
  }

  @override
  Future<Result<List<Shop>>> getShopsByCategory(String categoryId) {
    return _remoteDataSource.getShopsByCategory(categoryId);
  }

  @override
  Future<Result<Shop>> getShopById(String id) {
    return _remoteDataSource.getShopById(id);
  }

  @override
  Future<Result<List<Product>>> getShopProducts(String shopId) {
    return _remoteDataSource.getShopProductsById(shopId);
  }

  @override
  Future<Result<List<Category>>> getShopSubCategories(String shopId) {
    return _remoteDataSource.getShopSubCategories(shopId);
  }

  @override
  Future<Result> removeUserById(String userId) {
    return _remoteDataSource.removeUserById(userId);
  }

  @override
  Future<Result<List<NotificationMessage>>> getAllNotifications() {
    return _remoteDataSource.getAllNotifications();
  }

  @override
  Future<Result> deleteNotificationById(String id) {
    return _remoteDataSource.deleteNotificationById(id);
  }

  @override
  Future<Result> blockUser(String id, bool block) {
    return _remoteDataSource.blockUser(id, block);
  }

  @override
  Future<Result> removeShopById(String id) {
    return _remoteDataSource.removeShopById(id);
  }

  @override
  Future<void> logout() {
    return _sharedPreferencesManager.deleteUserData();
  }

  @override
  Future<Result<List<City>>> getCities() {
    return _fireStoreService.getCities();
  }

  @override
  Future<Result> addNewCity(City city) {
    return _fireStoreService.addNewCity(city);
  }

  @override
  Future<Result> updateCity(City city) {
    return _fireStoreService.updateCity(city);
  }
}
