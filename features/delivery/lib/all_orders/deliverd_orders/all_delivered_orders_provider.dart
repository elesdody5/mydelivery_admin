import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllDeliveredOrdersProvider extends BaseProvider {
  List<ShopOrder> _orders = [];
  List<ShopOrder> filteredOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateDeliveredOrderCount;

  AllDeliveredOrdersProvider(
      {DeliveryRepository? repository, this.updateDeliveredOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredOrders() async {
    _orders = await _repository.getDeliveredOrders();

    filteredOrders = [..._orders];
    if (updateDeliveredOrderCount != null) {
      updateDeliveredOrderCount!(_orders.length);
    }
    notifyListeners();
  }

  void searchOrder(String shopName) {
    filteredOrders = _orders
        .where((order) => order.shop?.name?.contains(shopName) == true)
        .toList(growable: false);
    notifyListeners();
  }
}
