import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class ShopDeliveredOrdersProvider extends BaseProvider {
  final VendorRepository _repository;

  ShopDeliveredOrdersProvider({VendorRepository? vendorRepository})
      : _repository = vendorRepository ?? VendorRepositoryImp();
  List<Order> orders = [];

  Future<void> getShopDeliveredOrders() async {
    List<Order> orders = await _repository.getShopDelivered();
    this.orders = orders;
    notifyListeners();
  }
}
