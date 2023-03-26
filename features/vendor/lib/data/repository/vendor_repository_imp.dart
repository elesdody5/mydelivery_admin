import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:vendor/data/firebase/firestore_service.dart';
import 'package:vendor/data/firebase/firestore_service_imp.dart';
import 'package:vendor/data/remote/vendor_remote_data_source.dart';
import 'package:vendor/data/remote/vendor_remote_data_source_imp.dart';
import 'package:vendor/data/repository/vendor_repository.dart';

class VendorRepositoryImp implements VendorRepository {
  final VendorRemoteDataSource _remoteDataSource;
  final SharedPreferencesManager _sharedPreferencesManager;
  final FireStoreService _fireStoreService;

  VendorRepositoryImp(
      {VendorRemoteDataSource? vendorRemoteDataSource,
      SharedPreferencesManager? sharedPreferencesManager,
      FireStoreService? fireStoreService})
      : _remoteDataSource =
            vendorRemoteDataSource ?? VendorRemoteDataSourceImp(),
        _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp(),
        _fireStoreService = fireStoreService ?? FireStoreServiceImp();

  @override
  Future<Result<List<Shop>>> getVendorShops() async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId != null) {
      Result<List<Shop>> result =
          await _remoteDataSource.getVendorShops(userId);
      if (result.succeeded()) {
        await _saveShopId(result.getDataIfSuccess().first);
      }
      return result;
    }
    return Error(Exception("User not found"));
  }

  Future<void> _saveShopId(Shop shop) async {
    if (shop.id != null) {
      await _sharedPreferencesManager.saveVendorShopId(shop.id!);
    }
  }

  @override
  Future<Result<List<Product>>> getShopProducts(String shopId) {
    return _remoteDataSource.getShopProducts(shopId);
  }

  @override
  Future<Result<List<Category>>> getShopSubCategories(String shopId) {
    return _remoteDataSource.getShopSubCategories(shopId);
  }

  @override
  Future<Result> removeProduct(String id) {
    return _remoteDataSource.removeProductById(id);
  }

  @override
  Future<Result<Category>> addSubCategory(String id, String subCategory) {
    return _remoteDataSource.addSubCategory(id, subCategory);
  }

  @override
  Future<Result<Product>> addProduct(Product product) {
    return _remoteDataSource.addProduct(product);
  }

  @override
  Future<Result<Product>> updateProduct(Product product) {
    return _remoteDataSource.updateProduct(product);
  }

  @override
  Future<Result<Shop>> getShopById(String shopId) {
    return _remoteDataSource.getShopById(shopId);
  }

  @override
  Future<Result<Shop>> addShop(Shop shop) async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId != null) {
      return _remoteDataSource.addShop(shop, userId);
    }
    return Error(Exception("User not found"));
  }

  @override
  Future<Result<Shop>> updateShop(Shop shop) {
    return _remoteDataSource.updateShop(shop);
  }

  @override
  Future<Result<List<Category>>> getAllCategory() {
    return _remoteDataSource.getAllCategory();
  }

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
  Future<Stream<List<ShopOrder>>> getShopOrders() async {
    String? shopId = await _sharedPreferencesManager.getVendorShopId();
    return _fireStoreService.getAvailableShopOrders(shopId ?? "");
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus orderStatus) {
    return _fireStoreService.updateOrderStatus(orderStatus, orderId);
  }

  @override
  Future<List<ShopOrder>> getShopDelivered() async {
    String? shopId = await _sharedPreferencesManager.getVendorShopId();
    return _fireStoreService.getDeliveredOrdersForShop(shopId ?? "");
  }

  @override
  Future<Result> removeSubCategory(String id) {
    return _remoteDataSource.removeSubCategory(id);
  }

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) {
    return _remoteDataSource.sendQuickOrder(quickOrder);
  }

  @override
  Future<Result> removeShop(String shopId) {
    return _remoteDataSource.removeShop(shopId);
  }

  @override
  Future<Result<List<User>>> getAllVendors() {
    return _remoteDataSource.getAllVendors();
  }

  @override
  Future<void> saveCurrentUserId(String id) {
    return _sharedPreferencesManager.saveUserId(id);
  }

  @override
  Future<Result> removeUserById(String id) {
    return _remoteDataSource.removeUser(id);
  }

  @override
  Future<Result<List<QuickOrder>>> getQuickOrderByUserId() async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId == null) return Error(Exception("User not found"));
    return _remoteDataSource.getVendorQuickOrder(userId);
  }
}
