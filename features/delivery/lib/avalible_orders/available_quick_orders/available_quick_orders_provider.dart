import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AvailableQuickOrderProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> orders = [];
  void Function(int)? updateAvailableQuickOrderCount;

  AvailableQuickOrderProvider(
      {DeliveryRepository? deliveryRepository,
      this.updateAvailableQuickOrderCount})
      : _repository = deliveryRepository ?? DeliveryRepositoryImp();

  Future<void> getAvailableQuickOrders() async {
    Result result = await _repository.getAvailableQuickOrders();
    if (result.succeeded()) {
      orders = result.getDataIfSuccess();
      if (updateAvailableQuickOrderCount != null) {
        updateAvailableQuickOrderCount!(orders.length);
      }
      notifyListeners();
    }
  }

  Future<void> pickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.pickQuickOrder(quickOrder.id ?? "");
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "pick_order_success_message";
    } else {
      errorMessage.value = "pick_order_error_body";
    }
  }
}
