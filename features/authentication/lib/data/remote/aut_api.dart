import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/data/remote/network_service.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/response.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';

import 'apis_url/auth_api_urls.dart';
import 'auth_service.dart';

class AuthApiServiceImp implements AuthApiService {
  Dio _dio;

  AuthApiServiceImp({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  @override
  Future<ApiResponse<LoginResponse>> login(
      String phone, String password) async {
    try {
      final response = await _dio.post(LOGIN,
          data: {"phone": phone, "password": password},
          queryParameters: {"lang": "lang".tr});
      if (response.statusCode != 200 && response.statusCode != 201) {
        print("error message is ${response.data['message']}");
        return ApiResponse(errorMessage: response.data['message']);
      }

      final responseData = response.data;
      String token = responseData['token'];
      UserType? type = stringToEnum(responseData['userType']);
      String? userId = responseData['userId'];
      addInterceptor(token);
      return ApiResponse(
          responseData:
              LoginResponse(token: token, userType: type, userId: userId));
    } catch (error) {
      print(error);
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }

  @override
  Future<ApiResponse<LoginResponse>> signUp(SignUpModel signUpModel) async {
    try {
      final response = await _dio.post(SIGN_UP,
          data: FormData.fromMap(await signUpModel.toJson()), queryParameters: {"lang": "lang".tr});

      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.data['message']);
        return ApiResponse(errorMessage: response.data['message']);
      }
      final responseData = response.data;
      String token = responseData['token'];
      UserType? type = stringToEnum(responseData['userType']);
      String? userId = responseData['userId'];
      return ApiResponse(
          responseData:
              LoginResponse(token: token, userType: type, userId: userId));
    } catch (error) {
      print(error);
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }

  @override
  Future<ApiResponse<String>> forgetPassword(String email) async {
    final response = await _dio.post(
      FORGET_PASSWORD,
      queryParameters: {"lang": "lang".tr},
      data: {
        "email": email,
      },
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      print(response.data['message']);
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: response.data['message']);
  }

  @override
  void addInterceptor(String token) {
    DioBuilder.addInterceptor(token);
  }

  @override
  Future<void> updateNotificationToken(
      String? userId, String? notificationToken) async {
    try {
      final response = await _dio.patch(UPDATE_NOTIFICATION_TOKEN,
          queryParameters: {
            "userId": userId,
            "notificationToken": notificationToken
          });
      if (response.statusCode != 200 && response.statusCode != 201) {
        print("Error update notification${response.data["message"]}");
      }
    } catch (e) {
      print("notification update error $e");
    }
  }

  @override
  Future<ApiResponse<bool>> updatePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final response = await _dio.patch(UPDATE_PASSWORD, data: {
        "passwordCurrent": oldPassword,
        'password': newPassword,
        'passwordConfirm': confirmPassword
      }, queryParameters: {
        "lang": "lang".tr
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.data['message']);
        return ApiResponse(errorMessage: response.data['message']);
      }

      return ApiResponse(responseData: true);
    } catch (error) {
      print(error);
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }

  @override
  Future<ApiResponse<String>> resetPassword(
      ResetPasswordModel resetPasswordModel) async {
    try {
      final response = await _dio.patch(
          RESET_PASSWORD + "${resetPasswordModel.token}",
          data: resetPasswordModel.toJson(),
          queryParameters: {"lang": "lang".tr});

      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.data['message']);
        return ApiResponse(errorMessage: response.data['message']);
      }
      return ApiResponse(responseData: response.data['message']);
    } catch (error) {
      print(error);
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }

  @override
  Future<ApiResponse> clearNotificationToken(String id) async {
    try {
      final response = await _dio.patch(UPDATE_NOTIFICATION_TOKEN,
          queryParameters: {"userId": id, "notificationToken": null});

      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.data['message']);
        return ApiResponse(errorMessage: response.data['message']);
      }
      return ApiResponse(responseData: response.data['message']);
    } catch (error) {
      print(error);
      return ApiResponse(errorMessage: "Something went wrong");
    }
  }
}
