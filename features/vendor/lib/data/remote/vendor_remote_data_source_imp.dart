import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:vendor/data/remote/network/vendor_api_service.dart';
import 'package:vendor/data/remote/network/vendor_api_service_imp.dart';
import 'package:vendor/data/remote/vendor_remote_data_source.dart';

class VendorRemoteDataSourceImp implements VendorRemoteDataSource {
  final VendorApiService _apiService;

  VendorRemoteDataSourceImp({VendorApiService? apiService})
      : _apiService = apiService ?? VendorApiServiceImp();

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
  Future<Result<List<Product>>> getShopProducts(String shopId) async {
    var response = await _apiService.getShopProducts(shopId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Category>>> getShopSubCategories(String shopId) async {
    var response = await _apiService.getShopSubCategories(shopId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Shop>>> getVendorShops(String userId) async {
    var response = await _apiService.getVendorShops(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeProductById(String id) async {
    var response = await _apiService.removeProductById(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Category>> addSubCategory(
      String shopId, String subCategory) async {
    var response = await _apiService.addSubCategory(shopId, subCategory);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Product>> addProduct(Product product) async {
    var response = await _apiService.addProduct(product);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Product>> updateProduct(Product product) async {
    var response = await _apiService.updateProduct(product);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Shop>> addShop(Shop shop, String userId) async {
    var response = await _apiService.addShop(shop, userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Shop>> getShopById(String shopId) async {
    var response = await _apiService.getShopById(shopId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<Shop>> updateShop(Shop shop) async {
    var response = await _apiService.updateShop(shop);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<Category>>> getAllCategory() async {
    var response = await _apiService.getAllCategories();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<User>> getUserById(String userId) async {
    var response = await _apiService.getUserById(userId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeSubCategory(String id) async {
    var response = await _apiService.removeSubCategory(id);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) async {
    var response = await _apiService.sendQuickOrder(quickOrder);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeShop(String shopId) async {
    var response = await _apiService.removeShop(shopId);
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<List<User>>> getAllVendors() async {
    var response = await _apiService.getAllVendors();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result> removeUser(String id) async {
    var response = await _apiService.removeUserById(id);
    return _getResultFromResponse(response);
  }
}
