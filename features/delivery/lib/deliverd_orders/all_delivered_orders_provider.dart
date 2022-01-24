import 'package:core/base_provider.dart';

class AllDeliveredOrdersProvider extends BaseProvider {
  int _deliveredQuickOrdersCount = 0;
  int _deliveredOrdersCount = 0;

  void setDeliveredOrdersCount(int count) {
    _deliveredOrdersCount = count;
    notifyListeners();
  }

  void setDeliveredQuickOrdersCount(int count) {
    _deliveredQuickOrdersCount = count;
    notifyListeners();
  }

  int get deliveredOrdersCount => _deliveredOrdersCount;

  int get deliveredQuickOrdersCount => _deliveredQuickOrdersCount;
}
