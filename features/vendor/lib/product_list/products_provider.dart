import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class ProductsProvider extends BaseProvider {
  List<Product> _allShopProducts = [];
  List<Category> subCategories = [];
  List<Product> currentSubCategoryProducts = [];
  final VendorRepository _repository;
  Category? selectedSubCategory;
  Shop? shop;

  ProductsProvider({VendorRepository? vendorRepository})
      : _repository = vendorRepository ?? VendorRepositoryImp();

  Future<void> init(Shop? shop) async {
    this.shop = shop;
    await getShopSubCategories(shop?.id);
    await getShopProducts(shop?.id);
    notifyListeners();
  }

  Future<void> getShopSubCategories(String? shopId) async {
    if (shopId == null) return;
    Result result = await _repository.getShopSubCategories(shopId);
    if (result.succeeded()) {
      subCategories = result.getDataIfSuccess();
      selectedSubCategory = subCategories.first;
    }
  }

  Future<void> getShopProducts(String? shopId) async {
    if (shopId == null) return;
    Result<List<Product>> result = await _repository.getShopProducts(shopId);
    if (result.succeeded()) {
      _allShopProducts = result.getDataIfSuccess();
      onSubCategorySelected(selectedSubCategory);
    }
  }

  void onSubCategorySelected(Category? subCategory) {
    selectedSubCategory = subCategory;
    currentSubCategoryProducts = _allShopProducts
        .where((element) => element.subCategoryId == subCategory?.id)
        .toList();
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    if (product.id != null) {
      isLoading.value = true;
      Result result = await _repository.removeProduct(product.id!);
      if (result.succeeded()) {
        _allShopProducts.remove(product);
        currentSubCategoryProducts.remove(product);
        notifyListeners();
      }
      isLoading.value = false;
    }
  }

  Future<void> addSubCategory(String? subCategory) async {
    if (subCategory != null && shop?.id != null) {
      isLoading.value = true;
      Result<Category> result =
          await _repository.addSubCategory(shop!.id!, subCategory);
      if (result.succeeded()) {
        subCategories.add(result.getDataIfSuccess());
        notifyListeners();
      } else {
        errorMessage.value = result.getErrorMessage();
      }
      isLoading.value = false;
    }
  }

  void addProduct(Product? product) {
    if (product != null) {
      _allShopProducts.add(product);
      currentSubCategoryProducts.add(product);
      notifyListeners();
    }
  }

  Future<void> removeSubCategory(Category? subCategory) async {
    if (subCategory != null) {
      isLoading.value = true;
      Result result = await _repository.removeSubCategory(subCategory.id!);
      isLoading.value = true;
      if (result.succeeded()) {
        subCategories.remove(subCategory);
        notifyListeners();
      }
    }
  }
}
