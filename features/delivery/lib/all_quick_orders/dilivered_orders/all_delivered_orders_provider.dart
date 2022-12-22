import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';

class AllDeliveredQuickOrdersProvider extends BaseProvider {
  final List<QuickOrder> _allDeliveredQuickOrders;
  List<QuickOrder> filteredQuickOrders = [];

  AllDeliveredQuickOrdersProvider(this._allDeliveredQuickOrders)
      : filteredQuickOrders = _allDeliveredQuickOrders;

  void searchQuickOrder(String quickOrderDetails) {
    filteredQuickOrders = _allDeliveredQuickOrders.where(
            (order) => order.address?.contains(quickOrderDetails) == true)
        .toList(growable: false);
    notifyListeners();
  }
}
