import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/domain/result.dart';

abstract class AuthRepository {
  Future<Result<LoginResponse>> login(String phone, String password);

  Future<Result<LoginResponse>> signUp(SignUpModel signUpModel);

  Future<Result<String>> forgetPassword(String s);

  Future<void> logout();

  Future<String> getLang();

  Future<LoginResponse> autoLogin();

  Future<void> saveNotificationToken(String? token);

  Future<Result<bool>> updatePassword(
      String oldPassword, String newPassword, String confirmPassword);

  Future<Result<String>> resetPassword(ResetPasswordModel resetPasswordModel);
}
