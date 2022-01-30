import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveredQuickOrdersProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> orders = [];
  void Function(int)? updateDeliveredQuickOrderCount;

  DeliveredQuickOrdersProvider(
      {DeliveryRepository? deliveryRepository,
      this.updateDeliveredQuickOrderCount})
      : _repository = deliveryRepository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredDeliveryOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getDeliveredQuickOrders();
    if (result.succeeded()) {
      orders = result.getDataIfSuccess();
      if (updateDeliveredQuickOrderCount != null) {
        updateDeliveredQuickOrderCount!(orders.length);
      }
      notifyListeners();
    }
  }

  void removeOrders() async {
    isLoading.value = true;
    List<String> ordersId = orders.map((order) => order.id ?? "").toList();
    await _repository.removeDeliveryQuickOrders(ordersId);
    isLoading.value = false;
    orders.clear();
    if (updateDeliveredQuickOrderCount != null) {
      updateDeliveredQuickOrderCount!(orders.length);
    }
     notifyListeners();
  }
}
