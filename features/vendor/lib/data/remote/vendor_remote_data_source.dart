import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';

abstract class VendorRemoteDataSource {
  Future<Result<List<Shop>>> getVendorShops(String userId);

  Future<Result<List<Category>>> getShopSubCategories(String shopId);

  Future<Result<List<Product>>> getShopProducts(String shopId);

  Future<Result> removeProductById(String id);

  Future<Result<Category>> addSubCategory(String shopId, String subCategory);

  Future<Result<Product>> updateProduct(Product product);

  Future<Result<Product>> addProduct(Product product);

  Future<Result<Shop>> addShop(Shop shop, String userId);

  Future<Result<Shop>> getShopById(String shopId);

  Future<Result<Shop>> updateShop(Shop shop);

  Future<Result<List<Category>>> getAllCategory();

  Future<Result<User>> getUserById(String userId);

  Future<Result> removeSubCategory(String id);

  Future<Result> sendQuickOrder(QuickOrder quickOrder);

  Future<Result> removeShop(String shopId);

  Future<Result<List<User>>> getAllVendors();

  Future<Result> removeUser(String id);

  Future<Result<List<QuickOrder>>> getVendorQuickOrder(String userId);
}
