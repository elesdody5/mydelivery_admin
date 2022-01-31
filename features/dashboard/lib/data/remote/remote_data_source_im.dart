import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/remote/network/api_service.dart';
import 'package:dashboard/data/remote/remote_data_source.dart';

import 'network/api_service_imp.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSourceImp({ApiService? apiService})
      : _apiService = apiService ?? ApiServiceImp();

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
  Future<Result<List<User>>> getAllUsers() async {
    var response = await _apiService.getAllUsers();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Offer>>> getAllOffers() async {
    var response = await _apiService.getAllOffers();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> deleteOffer(String offerId) async {
    var response = await _apiService.deleteOffer(offerId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> addOffer(Offer offer) async {
    var response = await _apiService.addOffer(offer);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Shop>>> getAllShops() async{
    var response = await _apiService.getAllShops();
    return _getResultFromResponse(response);
  }
}
