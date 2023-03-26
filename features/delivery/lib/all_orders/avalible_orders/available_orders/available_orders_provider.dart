import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/screens.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllAvailableOrdersProvider extends BaseProvider {
  List<User?> users = [];
  final DeliveryRepository _repository;
  List<ShopOrder> filteredOrders = [];
  List<ShopOrder> _orders = [];
  void Function(int)? updateAvailableOrderCount;

  AllAvailableOrdersProvider(
      {DeliveryRepository? repository, this.updateAvailableOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  void getAvailableOrders() async {
    List<ShopOrder> ordersStream = await _repository.getAvailableOrders();
    _orders = ordersStream;
    filteredOrders = [..._orders];
    users = _orders.map((order) => order.user).toSet().toList();
    if (updateAvailableOrderCount != null) {
      updateAvailableOrderCount!(users.length);
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
