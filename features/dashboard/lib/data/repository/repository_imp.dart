import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/offer.dart';
import 'package:dashboard/data/remote/remote_data_source.dart';
import 'package:dashboard/data/remote/remote_data_source_im.dart';
import 'package:dashboard/data/repository/repository.dart';

class MainRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final SharedPreferencesManager _sharedPreferencesManager;

  MainRepository(
      {RemoteDataSource? remoteDataSource,
      SharedPreferencesManager? sharedPreferencesManager})
      : _remoteDataSource = remoteDataSource ?? RemoteDataSourceImp(),
        _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp();

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
}
