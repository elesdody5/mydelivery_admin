import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/review.dart';
import 'package:delivery/data/firebase/firestore_service.dart';
import 'package:delivery/data/firebase/firestore_service_imp.dart';

import '../remote/delivery_remote_data_source.dart';
import '../remote/delivery_remote_source_imp.dart';
import 'delivery_repository.dart';

class DeliveryRepositoryImp implements DeliveryRepository {
  final SharedPreferencesManager _sharedPreferencesManager;
  final DeliveryRemoteDataSource _remoteDataSource;
  final FireStoreService _fireStoreService;

  DeliveryRepositoryImp(
      {SharedPreferencesManager? sharedPreferencesManager,
      DeliveryRemoteDataSource? deliveryRemoteDataSource,
      FireStoreService? fireStoreService})
      : _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp(),
        _remoteDataSource =
            deliveryRemoteDataSource ?? DeliveryRemoteDataSourceImp(),
        _fireStoreService = fireStoreService ?? FireStoreServiceImp();

  @override
  Future<Result<User>> getUserData() async {
    User? user = await _sharedPreferencesManager.getUserDetails();
    if (user != null) {
      return Success(user);
    } else {
      Result<User> user = await _getRemoteUserDetails();
      if (user.succeeded()) {
        await _sharedPreferencesManager
            .saveUserDetails(user.getDataIfSuccess());
      }
      return user;
    }
  }

  Future<Result<User>> _getRemoteUserDetails() async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId == null) return Error(Exception("User not found"));
    return _remoteDataSource.getUserById(userId);
  }

  @override
  Future<Result> addDeliveryToOrders(List<Order> orders) async {
    Result<User> delivery = await getUserData();
    if (delivery.succeeded()) {
      return _fireStoreService.addDeliveryToOrders(
          delivery.getDataIfSuccess(), orders);
    } else {
      return delivery;
    }
  }

  @override
  Stream<List<Order>> getAvailableOrders() {
    return _fireStoreService.getAvailableOrders();
  }

  @override
  Future<Stream<List<Order>>> getCurrentDeliveryOrders(String userId) async {
    return _fireStoreService.getCurrentDeliveryOrders(userId ?? "");
  }

  @override
  Future<List<Order>> getDeliveredOrdersForDelivery(String userId) async {
    return _fireStoreService.getDeliveredOrdersForDelivery(userId ?? "");
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus) {
    return _fireStoreService.updateOrderStatus(orderStatus, orderId);
  }

  @override
  Future<Result<List<QuickOrder>>> getAvailableQuickOrders() {
    return _remoteDataSource.getAvailableQuickOrders();
  }

  @override
  Future<Result> pickQuickOrder(String quickOrderId) async {
    String? userId = await _sharedPreferencesManager.getUserId();
    return _remoteDataSource.pickQuickOrder(quickOrderId, userId ?? "");
  }

  @override
  Future<Result<List<QuickOrder>>> getCurrentDeliveryQuickOrders(String userId) async {
    return _remoteDataSource.getCurrentDeliveryQuickOrder(userId ?? "");
  }

  @override
  Future<Result> updateQuickOrderStatus(String quickOrderId, String status) {
    return _remoteDataSource.updateQuickOrderStatus(quickOrderId, status);
  }

  @override
  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(String userId) async {
    return _remoteDataSource.getDeliveredQuickOrders(userId ?? "");
  }

  @override
  Future<Result<List<User>>> getAllDelivery() {
    return _remoteDataSource.getAllDelivery();
  }

  @override
  Future<void> saveCurrentUserId(String id) {
    return _sharedPreferencesManager.saveUserId(id);
  }

  @override
  Future<Result> removeUserById(String id) {
    return _remoteDataSource.removeUserById(id);
  }

  @override
  Future<void> removeDeliveryOrders(List<String> ordersId) {
    return _fireStoreService.removeOrdersIds(ordersId);
  }

  @override
  Future<void> removeDeliveryQuickOrders(List<String> ordersId) {
    return _remoteDataSource.removeQuickOrders(ordersId);
  }

  @override
  Future<Result<List<Review>>> getAllDeliveryReviews(String deliveryId) {
    return _remoteDataSource.getAllDeliveryReviews(deliveryId);

  }
}
