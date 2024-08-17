import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllWithDeliveryOrdersProvider extends BaseProvider {
  List<ShopOrder> _orders = [];
  List<ShopOrder> filteredOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateWithDeliveryOrderCount;

  AllWithDeliveryOrdersProvider(
      {DeliveryRepository? repository, this.updateWithDeliveryOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  void searchOrder(String shopName) {
    filteredOrders = _orders
        .where((order) => order.shop?.name?.contains(shopName) == true)
        .toList(growable: false);
    notifyListeners();
  }

  Future<void> getWithDeliveryOrders() async {
    _orders = await _repository.getWithDeliveryOrders();
    _orders.sort((first, second) =>
    second.dateTime?.compareTo(first.dateTime!) ?? 0);
    filteredOrders = [..._orders];
    if (updateWithDeliveryOrderCount != null) {
      updateWithDeliveryOrderCount!(_orders.length);
    }
    notifyListeners();
  }
}
