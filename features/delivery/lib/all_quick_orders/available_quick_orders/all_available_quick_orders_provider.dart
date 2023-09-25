import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AllAvailableQuickOrdersProvider extends BaseProvider {
  List<QuickOrder> _orders = [];
  List<QuickOrder> filteredQuickOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateAvailableQuickOrderCount;

  AllAvailableQuickOrdersProvider(
      {DeliveryRepository? repository, this.updateAvailableQuickOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getAvailableDeliveryOrders() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    Result<List<QuickOrder>> result =
        await _repository.getAvailableQuickOrders(packageInfo.version);
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredQuickOrders = [..._orders];
      if (updateAvailableQuickOrderCount != null) {
        updateAvailableQuickOrderCount!(_orders.length);
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

  Future<void> deleteQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.removeQuickOrder(quickOrder.id);
    if (result.succeeded()) {
      _orders.remove(quickOrder);
      filteredQuickOrders = [..._orders];
    } else {
      errorMessage.value = "something_went_wrong";
    }
    isLoading.value = false;
    notifyListeners();
  }

  void updateQuickOrderInList(QuickOrder? quickOrder) {
    if (quickOrder != null) {
      int index = _orders.indexWhere((element) => element.id == quickOrder.id);
      _orders[index] = quickOrder;
      filteredQuickOrders = [..._orders];
      notifyListeners();
    }
  }
}
