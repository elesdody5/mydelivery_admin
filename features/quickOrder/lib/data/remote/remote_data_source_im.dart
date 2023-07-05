import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';

import 'network/api_service.dart';
import 'network/api_service_imp.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSourceImp({ApiService? apiService})
      : _apiService = apiService ?? ApiServiceImp();

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

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) async {
    var response = await _apiService.addQuickOrder(quickOrder);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Shop>>> getAllShops() async {
    var response = await _apiService.getAllShops();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> updateQuickOrder(QuickOrder quickOrder) async {
    var removeResponse = await _apiService.removeQuickOrder(quickOrder.id);
    Result result = _getResultFromResponse(removeResponse);
    if (result.succeeded()) {
      var response = await _apiService.addQuickOrder(quickOrder);
      return _getResultFromResponse(response);
    } else {
      return _getResultFromResponse(removeResponse);
    }
  }
}
