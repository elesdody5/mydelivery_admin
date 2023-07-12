import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:quickorder/data/repository/repository.dart';
import 'package:quickorder/data/repository/repository_imp.dart';

class ScheduledQuickOrdersProvider extends BaseProvider {
  final Repository _repository;

  List<QuickOrder> quickOrders = [];

  ScheduledQuickOrdersProvider({Repository? repository})
      : _repository = repository ?? QuickOrderRepository();

  Future<void> getScheduledQuickOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getScheduledQuickOrder();
    if (result.succeeded()) {
      quickOrders = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> addQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    int index =
        quickOrders.indexWhere((element) => element.id == quickOrder.id);
    quickOrders.removeAt(index);

    quickOrder.dateTime = DateTime.now();
    await _repository.sendQuickOrder(quickOrder);

    isLoading.value = false;
    notifyListeners();
  }

  Future<void> deleteQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    await _repository.deleteScheduledQuickOrder(quickOrder);
    quickOrders.remove(quickOrder);
    isLoading.value = false;
    notifyListeners();
  }
}
