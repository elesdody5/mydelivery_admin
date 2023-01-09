import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllDeliveredQuickOrdersProvider extends BaseProvider {
  List<QuickOrder> _orders = [];
  List<QuickOrder> filteredQuickOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateDeliveredQuickOrderCount;

  AllDeliveredQuickOrdersProvider(
      {DeliveryRepository? repository, this.updateDeliveredQuickOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredQuickOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getAllDeliveredQuickOrders();
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredQuickOrders = [..._orders];
      if (updateDeliveredQuickOrderCount != null) {
        updateDeliveredQuickOrderCount!(_orders.length);
      }
      notifyListeners();
    }
  }

  void searchQuickOrder(String quickOrderDetails) {
    filteredQuickOrders = _orders
        .where((order) => order.address?.contains(quickOrderDetails) == true)
        .toList(growable: false);
    notifyListeners();
  }
}
