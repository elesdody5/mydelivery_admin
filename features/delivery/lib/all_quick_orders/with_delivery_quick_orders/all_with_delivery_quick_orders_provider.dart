import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllWithDeliveryQuickOrdersProvider extends BaseProvider {
  List<QuickOrder> _orders = [];
  List<QuickOrder> filteredQuickOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateWithDeliveryQuickOrderCount;

  AllWithDeliveryQuickOrdersProvider(
      {DeliveryRepository? repository, this.updateWithDeliveryQuickOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  void searchQuickOrder(String quickOrderDetails) {
    filteredQuickOrders = _orders
        .where((order) => order.address?.contains(quickOrderDetails) == true)
        .toList(growable: false);
    notifyListeners();
  }

  Future<void> getWithDeliveryOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getAllWithDeliveryQuickOrders();
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredQuickOrders = [..._orders];
      if (updateWithDeliveryQuickOrderCount != null) {
        updateWithDeliveryQuickOrderCount!(_orders.length);
      }
      notifyListeners();
    }
  }
}
