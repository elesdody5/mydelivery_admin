import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class CurrentDeliveryOrdersProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<ShopOrder> orders = [];
  void Function(int)? updateCurrentOrderCount;

  CurrentDeliveryOrdersProvider(
      {DeliveryRepository? repository, this.updateCurrentOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveryOrders(String userId) async {
    Stream<List<ShopOrder>> stream = await _repository.getCurrentDeliveryOrders(userId);
    stream.listen((event) {
      orders = event;
      if (updateCurrentOrderCount != null) {
        updateCurrentOrderCount!(orders.length);
      }
      notifyListeners();
    });
  }

  Future<void> updateOrderStatus(
      OrderStatus orderStatus, String orderId) async {
    await _repository.updateOrderStatus(orderId, orderStatus);
  }
}
