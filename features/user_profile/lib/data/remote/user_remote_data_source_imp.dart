import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/order.dart';
import 'package:core/model/response.dart';
import 'package:user_profile/data/model/update_password_model.dart';
import 'package:user_profile/data/remote/network/user_api_service.dart';
import 'package:user_profile/data/remote/network/user_api_service_imp.dart';
import 'package:user_profile/data/remote/user_remote_data_source.dart';

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final UserApiService _apiService;

  UserRemoteDataSourceImp({UserApiService? apiService})
      : _apiService = apiService ?? UserApiServiceImp();

  Result<T> _getResultFromResponse<T>(ApiResponse apiResponse) {
    try {
      if (apiResponse.errorMessage != null) {
        return Error(ApiException(apiResponse.errorMessage!));
      } else {
        return Success(apiResponse.responseData);
      }
    } catch (error) {
      print("auth api error $error");
      return Error(ApiException("Something went wrong"));
    }
  }

  @override
  Future<Result<User>> getUserDetails(String userId) async {
    var response = await _apiService.getUserDetails(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updatePassword(UpdatePasswordModel updatePasswordModel) async {
    var response = await _apiService.updatePassword(updatePasswordModel);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateUser(User user) async {
    var response = await _apiService.updateUser(user);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getCurrentQuickOrders(String userId) async {
    var response = await _apiService.getCurrentQuickOrders(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(
      String userId) async {
    var response = await _apiService.getDeliveredQuickOrders(userId);
    return _getResultFromResponse(response);
  }
}
