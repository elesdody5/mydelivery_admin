import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:user_profile/data/model/update_password_model.dart';
import 'package:user_profile/data/remote/user_remote_data_source.dart';
import 'package:user_profile/data/remote/user_remote_data_source_imp.dart';
import 'package:user_profile/data/repository/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final SharedPreferencesManager _sharedPreferencesManager;
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImp(
      {SharedPreferencesManager? sharedPreferencesManager,
      UserRemoteDataSource? userRemoteDataSource})
      : _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp(),
        _remoteDataSource = userRemoteDataSource ?? UserRemoteDataSourceImp();

  @override
  Future<Result> updatePassword(UpdatePasswordModel updatePasswordModel) {
    return _remoteDataSource.updatePassword(updatePasswordModel);
  }

  @override
  Future<Result> updateUser(User user) async {
    Result result = await _remoteDataSource.updateUser(user);
    if (result.succeeded()) {
      await _sharedPreferencesManager.saveUserDetails(user);
    }
    return result;
  }

  @override
  Future<Result<User>> getUserDetails() async {
    Result<User> user = await _getRemoteUserDetails();
    return user;
  }

  Future<Result<User>> _getRemoteUserDetails() async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId == null) return Error(Exception("User not found"));
    return _remoteDataSource.getUserDetails(userId);
  }
}
