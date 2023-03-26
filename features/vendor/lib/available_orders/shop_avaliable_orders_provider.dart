import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class ShopAvailableOrdersProvider extends BaseProvider {
  final VendorRepository _repository;

  ShopAvailableOrdersProvider({VendorRepository? vendorRepository})
      : _repository = vendorRepository ?? VendorRepositoryImp();
  List<ShopOrder> orders = [];

  Future<void> getShopOrders() async {
    Stream<List<ShopOrder>> stream = await _repository.getShopOrders();
    stream.listen((event) {
      orders = event;
      notifyListeners();
    });
  }

  Future<void> updateOrderStatus(
      OrderStatus orderStatus, String orderId) async {
    await _repository.updateOrderStatus(orderId, orderStatus);
  }
}
