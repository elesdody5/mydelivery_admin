import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class VendorShopsProvider extends BaseProvider {
  final VendorRepository _vendorRepository;
  List<Shop> shops = [];
  String? shopDestination;
  QuickOrder quickOrder = QuickOrder();

  VendorShopsProvider({VendorRepository? vendorRepository})
      : _vendorRepository = vendorRepository ?? VendorRepositoryImp();

  set destination(String? destination) {
    shopDestination ??= destination;
  }

  void addShop(Shop? shop) {
    if (shop != null) {
      shops.add(shop);
      notifyListeners();
    }
  }

  Future<void> sendQuickOrder() async {
    isLoading.value = true;
    Result result = await _vendorRepository.sendQuickOrder(quickOrder);
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "quick_order_successfully";
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }

  Future<void> getVendorShops() async {
    Result<List<Shop>> result = await _vendorRepository.getVendorShops();
    if (result.succeeded()) {
      shops = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> removeShop(Shop shop) async {
    isLoading.value = true;
    Result result = await _vendorRepository.removeShop(shop.id ?? "");
    isLoading.value = false;
    if (result.succeeded()) {
      shops.remove(shop);
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
}
