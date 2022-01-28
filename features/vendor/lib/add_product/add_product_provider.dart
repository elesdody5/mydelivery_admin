import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class AddProductProvider extends BaseProvider {
  AddProductProvider({VendorRepository? vendorRepository})
      : _vendorRepository = vendorRepository ?? VendorRepositoryImp();
  Product product = Product();
  final VendorRepository _vendorRepository;
  List<Category> subCategory = [];

  Future<void> save() async {
    if (product.id != null) {
      isLoading.value = true;
      Result<Product> result = await _vendorRepository.updateProduct(product);
      isLoading.value = false;
      if (result.succeeded()) {
        product = result.getDataIfSuccess();
        successMessage.value = "update_product_successful_message";
      } else {
        errorMessage.value = "update_product_error_message";
      }
    } else {
      isLoading.value = true;
      Result<Product> result = await _vendorRepository.addProduct(product);
      isLoading.value = false;
      if (result.succeeded()) {
        product = result.getDataIfSuccess();
        successMessage.value = "update_product_successful_message";
      } else {
        errorMessage.value = "update_product_error_message";
      }
    }
  }

  void init(Product? product, List<Category>? subCategory, String? shopId) {
    if (product != null) {
      this.product = product;
    }
    if (subCategory != null) {
      this.subCategory = subCategory;
    }
    if (shopId != null) {
      this.product.shopId = shopId;
    }
  }
}
