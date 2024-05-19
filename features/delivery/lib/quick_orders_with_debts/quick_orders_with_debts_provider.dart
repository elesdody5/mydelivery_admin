import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class QuickOrdersWithDebtsProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> quickOrders = [];
  double totalDebts = 0;

  QuickOrdersWithDebtsProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveryQuickOrdersWithDebts(String deliveryId) async {
    Result<List<QuickOrder>> result =
        await _repository.getDeliveryQuickOrderWithDebts(deliveryId);
    if (result.succeeded()) {
      quickOrders = result.getDataIfSuccess();
      for (var quickOrder in quickOrders) {
        totalDebts += quickOrder.debt ?? 0;
      }
    }
  }

  Future<void> updateQuickOrderDebt(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.updateQuickOrderDebt(quickOrder.id, 0);
    isLoading.value = false;
    if (result.succeeded()) {
      quickOrders.remove(quickOrder);
      totalDebts -= quickOrder.debt ?? 0;
    } else {
      errorMessage.value = "something_went_wrong";
    }
    notifyListeners();
  }
}
