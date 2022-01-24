import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/model/response.dart';

abstract class AuthApiService {
  Future<ApiResponse<LoginResponse>> login(String phone, String password);

  Future<ApiResponse<LoginResponse>> signUp(SignUpModel user);

  Future<ApiResponse<String>> forgetPassword(String email);

  void addInterceptor(String token);

  Future<void> updateNotificationToken(
      String? userId, String? notificationToken);

  Future<ApiResponse<String>> resetPassword(
      ResetPasswordModel resetPasswordModel);

  Future<ApiResponse> clearNotificationToken(String id);

  Future<ApiResponse> updatePassword(
      String oldPassword, String newPassword, String confirmPassword);
}
