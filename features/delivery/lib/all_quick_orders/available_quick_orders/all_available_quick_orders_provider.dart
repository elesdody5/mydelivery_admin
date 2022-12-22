import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';

class AllAvailableQuickOrdersProvider extends BaseProvider {
  final List<QuickOrder> _allAvailableQuickOrders;
  List<QuickOrder> filteredQuickOrders = [];

  AllAvailableQuickOrdersProvider(this._allAvailableQuickOrders)
      : filteredQuickOrders = _allAvailableQuickOrders;

  void searchQuickOrder(String quickOrderDetails) {
    filteredQuickOrders = _allAvailableQuickOrders.where(
            (order) => order.address?.contains(quickOrderDetails) == true)
        .toList(growable: false);
    notifyListeners();
  }
}
