import 'package:core/data/remote/network_service.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/response.dart';
import 'package:dio/dio.dart';
import 'package:user_profile/data/model/update_password_model.dart';
import 'package:user_profile/data/remote/network/urls/urls.dart';
import 'package:user_profile/data/remote/network/user_api_service.dart';

class UserApiServiceImp implements UserApiService {
  final Dio _dio;

  UserApiServiceImp({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  @override
  Future<ApiResponse<User>> getUserDetails(String userId) async {
    final response =
        await _dio.get(userDetailsUrl, queryParameters: {"userId": userId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    User user = User.fromJson(response.data['user']);
    return ApiResponse(responseData: user);
  }

  @override
  Future<ApiResponse> updatePassword(
      UpdatePasswordModel updatePasswordModel) async {
    final response =
        await _dio.post(updatePasswordUrl, data: updatePasswordModel.toJson());
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> updateUser(User user) async {
    final response = await _dio.patch(userDetailsUrl,
        queryParameters: {"userId": user.id},
        data: FormData.fromMap(await user.toJsonWithImage()));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }
}
