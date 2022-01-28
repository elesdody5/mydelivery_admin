import 'package:core/data/remote/network_service.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';
import 'package:dio/dio.dart';
import 'package:vendor/data/remote/api_urls/urls.dart';
import 'package:vendor/data/remote/network/vendor_api_service.dart';

class VendorApiServiceImp implements VendorApiService {
  final Dio _dio;

  VendorApiServiceImp({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  @override
  Future<ApiResponse<List<Product>>> getShopProducts(String shopId) async {
    final response =
        await _dio.get(productsUrl, queryParameters: {"shopId": shopId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Product> products = [];
    response.data["products"]
        .forEach((json) => products.add(Product.fromJson(json)));
    return ApiResponse(responseData: products);
  }

  @override
  Future<ApiResponse<List<Category>>> getShopSubCategories(
      String shopId) async {
    final response =
        await _dio.get(subCategoriesUrl, queryParameters: {"shopId": shopId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Category> categories = [];
    response.data["subCategories"]
        .forEach((json) => categories.add(Category.fromJson(json)));
    return ApiResponse(responseData: categories);
  }

  @override
  Future<ApiResponse<List<Shop>>> getVendorShops(String userId) async {
    final response =
        await _dio.get(vendorShopsUrl, queryParameters: {"userId": userId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Shop> shops = [];
    response.data["shopsOwner"]
        .forEach((json) => shops.add(Shop.fromJson(json)));
    return ApiResponse(responseData: shops);
  }

  @override
  Future<ApiResponse> removeProductById(String id) async {
    final response =
        await _dio.delete(productUrl, queryParameters: {"productId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse<Category>> addSubCategory(
      String shopId, String subCategoryName) async {
    final response = await _dio.post(subCategoryUrl,
        queryParameters: {"shopId": shopId}, data: {"name": subCategoryName});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Category subCategory = Category.fromJson(response.data["subCategory"]);
    return ApiResponse(responseData: subCategory);
  }

  @override
  Future<ApiResponse<Product>> addProduct(Product product) async {
    final response = await _dio.post(productUrl,
        queryParameters: {
          "shopId": product.shopId,
          "subCategoryId": product.subCategoryId
        },
        data: FormData.fromMap(await product.toJsonWithImage()));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Product createdProduct = Product.fromJson(response.data["createdElement"]);
    return ApiResponse(responseData: createdProduct);
  }

  @override
  Future<ApiResponse<Product>> updateProduct(Product product) async {
    final response = await _dio.patch(productUrl,
        queryParameters: {"productId": product.id},
        data: FormData.fromMap(await product.toJsonWithImage()));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Product createdProduct = Product.fromJson(response.data["updatedElement"]);
    return ApiResponse(responseData: createdProduct);
  }

  @override
  Future<ApiResponse<Shop>> addShop(Shop shop, String userId) async {
    final response = await _dio.post(shopUrl,
        queryParameters: {"userId": userId, "categoryId": shop.category?.id},
        data: FormData.fromMap(await shop.toJsonWithImage()));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Shop createdShop = Shop.fromJson(response.data["createdElement"]);
    return ApiResponse(responseData: createdShop);
  }

  @override
  Future<ApiResponse<Shop>> getShopById(String shopId) async {
    final response = await _dio.get(
      shopUrl,
      queryParameters: {"shopId": shopId},
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Shop createdShop = Shop.fromJson(response.data["shop"]);
    return ApiResponse(responseData: createdShop);
  }

  @override
  Future<ApiResponse<Shop>> updateShop(Shop shop) async {
    final response = await _dio.patch(shopUrl,
        queryParameters: {"shopId": shop.id},
        data: FormData.fromMap(await shop.toJsonWithImage()));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    Shop createdShop = Shop.fromJson(response.data["shop"]);
    return ApiResponse(responseData: createdShop);
  }

  @override
  Future<ApiResponse<List<Category>>> getAllCategories() async {
    final response = await _dio.get(categoriesUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<Category> categories = [];
    response.data["categories"]
        .forEach((json) => categories.add(Category.fromJson(json)));
    return ApiResponse(responseData: categories);
  }

  @override
  Future<ApiResponse<User>> getUserById(String userId) async {
    final response =
        await _dio.get(userUrl, queryParameters: {"userId": userId});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    User user = User.fromJson(response.data["user"]);
    return ApiResponse(responseData: user);
  }

  @override
  Future<ApiResponse> removeSubCategory(String id) async {
    final response = await _dio
        .delete(subCategoryUrl, queryParameters: {"subCategoryId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> sendQuickOrder(QuickOrder quickOrder) async {
    final response = await _dio.post(quickOrderUrl,
        queryParameters: {"userType": "delivery"}, data: quickOrder.toJson());
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> removeShop(String id) async {
    final response =
        await _dio.delete(shopUrl, queryParameters: {"shopId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }

  @override
  Future<ApiResponse> getAllVendors() async {
    final response = await _dio.get(vendorsUrl,
        queryParameters: {"userType": UserType.vendor.enmToString()});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    List<User> vendorList = [];
    response.data["users"]
        .forEach((json) => vendorList.add(User.fromJson(json)));
    return ApiResponse(responseData: vendorList);
  }

  @override
  Future<ApiResponse> removeUserById(String id) async {
    final response =
        await _dio.delete(userUrl, queryParameters: {"userId": id});
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    return ApiResponse(responseData: true);
  }
}
