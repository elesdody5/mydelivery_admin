import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/domain/result.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponse>> login(String phone, String password);

  Future<Result<LoginResponse>> signUp(SignUpModel user);

  Future<Result<String>> forgetPassword(String email);

  void addInterceptor(String token);

  Future<void> updateNotificationToken(
      String? userId, String? notificationToken);

  Future<Result<bool>> updatePassword(
      String oldPassword, String newPassword, String confirmPassword);

  Future<Result<String>> resetPassword(ResetPasswordModel resetPasswordModel);

  Future<Result> clearNotificationToken(String id);
}
