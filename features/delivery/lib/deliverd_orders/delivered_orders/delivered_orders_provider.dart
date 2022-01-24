import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveredOrdersProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<Order> orders = [];
  void Function(int)? updateDeliveredOrderCount;

  DeliveredOrdersProvider(
      {DeliveryRepository? repository, this.updateDeliveredOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredOrders() async {
    orders = await _repository.getDeliveredOrdersForDelivery();
    if (updateDeliveredOrderCount != null) {
      updateDeliveredOrderCount!(orders.length);
    }
    notifyListeners();
  }
}
