import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';

class AllWithDeliveryQuickOrdersProvider extends BaseProvider {
  final List<QuickOrder> _allWithDeliveryQuickOrders;
  List<QuickOrder> filteredQuickOrders = [];

  AllWithDeliveryQuickOrdersProvider(this._allWithDeliveryQuickOrders)
      : filteredQuickOrders = _allWithDeliveryQuickOrders;

  void searchQuickOrder(String quickOrderDetails) {
    filteredQuickOrders = _allWithDeliveryQuickOrders.where(
            (order) => order.address?.contains(quickOrderDetails) == true)
        .toList(growable: false);
    notifyListeners();
  }
}
