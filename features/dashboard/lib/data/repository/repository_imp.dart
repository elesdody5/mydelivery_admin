import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/firebase/firestore_service.dart';
import 'package:dashboard/data/firebase/firestore_service_imp.dart';
import 'package:dashboard/data/remote/remote_data_source.dart';
import 'package:dashboard/data/remote/remote_data_source_im.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/domain/model/order_settings.dart';

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
  Future<Result<OrderSettings>> getOrderSettings() {
    return _fireStoreService.getOrderSettings();
  }

  @override
  Future<Result> updateOrderSettings(OrderSettings orderSettings) {
    return _fireStoreService.updateOrderSettings(orderSettings);
  }
}
