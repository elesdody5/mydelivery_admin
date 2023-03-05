import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order_status.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class CurrentQuickOrderProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> orders = [];
  void Function(int)? updateCurrentQuickOrderCount;

  CurrentQuickOrderProvider(
      {DeliveryRepository? deliveryRepository,
      this.updateCurrentQuickOrderCount})
      : _repository = deliveryRepository ?? DeliveryRepositoryImp();

  Future<void> getCurrentDeliveryOrders(String userId) async {
    Result<List<QuickOrder>> result =
        await _repository.getCurrentDeliveryQuickOrders(userId);
    if (result.succeeded()) {
      orders = result.getDataIfSuccess();
      if (updateCurrentQuickOrderCount != null) {
        updateCurrentQuickOrderCount!(orders.length);
      }
      notifyListeners();
    }
  }

  Future<void> changeQuickOrderStatus(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.updateQuickOrderStatus(
        quickOrder.id ?? "", OrderStatus.delivered.enumToString());
    isLoading.value = false;
    if (result.succeeded()) {
      orders.remove(quickOrder);
      if (updateCurrentQuickOrderCount != null) {
        updateCurrentQuickOrderCount!(orders.length);
      }
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
  Future<void> deleteQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.removeQuickOrder(quickOrder.id);
    if (result.succeeded()) {
      orders.remove(quickOrder);
    } else {
      errorMessage.value = "something_went_wrong";
    }
    isLoading.value = false;
    notifyListeners();
  }
}
