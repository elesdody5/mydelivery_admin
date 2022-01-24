import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:user_profile/data/model/update_password_model.dart';

abstract class UserRemoteDataSource {
  Future<Result<User>> getUserDetails(String userId);

  Future<Result> updateUser(User user);

  Future<Result> updatePassword(UpdatePasswordModel updatePasswordModel);
}
