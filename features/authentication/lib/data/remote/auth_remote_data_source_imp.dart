import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/data/remote/aut_api.dart';
import 'package:authentication/data/remote/auth_remote_data_source.dart';
import 'package:authentication/data/remote/auth_service.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthApiService _apiService;

  AuthRemoteDataSourceImp({AuthApiService? apiService})
      : _apiService = apiService ?? AuthApiServiceImp();

  @override
  void addInterceptor(String token) {
    _apiService.addInterceptor(token);
  }

  @override
  Future<Result> clearNotificationToken(String id) async {
    var result = await _apiService.clearNotificationToken(id);
    return _getResultFromResponse(result);
  }

  @override
  Future<Result<String>> forgetPassword(String email) async {
    var result = await _apiService.forgetPassword(email);
    return _getResultFromResponse(result);
  }

  @override
  Future<Result<LoginResponse>> login(String phone, String password) async {
    var result = await _apiService.login(phone, password);
    return _getResultFromResponse(result);
  }

  @override
  Future<Result<String>> resetPassword(
      ResetPasswordModel resetPasswordModel) async {
    var result = await _apiService.resetPassword(resetPasswordModel);
    return _getResultFromResponse(result);
  }

  @override
  Future<Result<LoginResponse>> signUp(SignUpModel user) async {
    var result = await _apiService.signUp(user);
    return _getResultFromResponse(result);
  }

  @override
  Future<void> updateNotificationToken(
      String? userId, String? notificationToken) async {
    await _apiService.updateNotificationToken(userId, notificationToken);
  }

  @override
  Future<Result<bool>> updatePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    var result = await _apiService.updatePassword(
        oldPassword, newPassword, confirmPassword);
    return _getResultFromResponse(result);
  }

  Result<T> _getResultFromResponse<T>(ApiResponse apiResponse) {
    try {
      if (apiResponse.errorMessage != null) {
        return Error(ApiException(apiResponse.errorMessage!));
      } else if (apiResponse.networkError == true) {
        return Error(ApiException("networkError", networkError: true));
      } else {
        return Success(apiResponse.responseData);
      }
    } catch (error) {
      print("auth api error $error");
      return Error(ApiException("Something went wrong"));
    }
  }
}
