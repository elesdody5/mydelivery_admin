import 'package:core/domain/user.dart';
import 'package:core/model/response.dart';
import 'package:user_profile/data/model/update_password_model.dart';

abstract class UserApiService {
  Future<ApiResponse<User>> getUserDetails(String userId);

  Future<ApiResponse> updateUser(User user);

  Future<ApiResponse> updatePassword(UpdatePasswordModel updatePasswordModel);
}
