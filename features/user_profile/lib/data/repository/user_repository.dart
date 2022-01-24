import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:user_profile/data/model/update_password_model.dart';

abstract class UserRepository {
  Future<Result> updateUser(User user);

  Future<Result> updatePassword(UpdatePasswordModel updatePasswordModel);

  Future<Result<User>> getUserDetails();
}
