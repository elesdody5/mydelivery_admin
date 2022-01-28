import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class VendorsListProvider extends BaseProvider {
  List<User> vendorsList = [];
  final VendorRepository _repository;

  VendorsListProvider({VendorRepository? repository})
      : _repository = repository ?? VendorRepositoryImp();

  Future<void> getAllVendors() async {
    Result<List<User>> result = await _repository.getAllVendors();
    if (result.succeeded()) {
      vendorsList = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  void onDeliveryClicked(String id) async {
    isLoading.value = true;
    await _repository.saveCurrentUserId(id);
    isLoading.value = false;
    navigation.value = NavigationDestination(routeName: vendorHomeScreen);
  }

  Future<void> removeVendor(User vendor) async {
    isLoading.value = true;
    Result result = await _repository.removeUserById(vendor.id ?? "");
    isLoading.value = false;
    if (result.succeeded()) {
      vendorsList.remove(vendor);
      notifyListeners();
    }
  }
}