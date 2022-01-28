import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';

abstract class VendorApiService {
  Future<ApiResponse<List<Shop>>> getVendorShops(String userId);

  Future<ApiResponse<List<Category>>> getShopSubCategories(String shopId);

  Future<ApiResponse<List<Product>>> getShopProducts(String shopId);

  Future<ApiResponse> removeProductById(String id);

  Future<ApiResponse<Category>> addSubCategory(
      String shopId, String subCategory);

  Future<ApiResponse<Product>> updateProduct(Product product);

  Future<ApiResponse<Product>> addProduct(Product product);

  Future<ApiResponse<Shop>> addShop(Shop shop, String userId);

  Future<ApiResponse<Shop>> updateShop(Shop shop);

  Future<ApiResponse<Shop>> getShopById(String shopId);

  Future<ApiResponse<List<Category>>> getAllCategories();

  Future<ApiResponse<User>> getUserById(String userId);

  Future<ApiResponse> removeSubCategory(String id);

  Future<ApiResponse> sendQuickOrder(QuickOrder quickOrder);

  Future<ApiResponse> removeShop(String shopId);

  Future<ApiResponse> getAllVendors();

  Future<ApiResponse> removeUserById(String id) ;
}
