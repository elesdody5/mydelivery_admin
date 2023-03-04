import 'package:core/base_provider.dart';

class AllCurrentUserOrdersProvider extends BaseProvider {
  int _currentQuickOrdersCount = 0;
  int _currentOrdersCount = 0;

  void setCurrentOrdersCount(int count) {
    _currentOrdersCount = count;
    notifyListeners();
  }

  void setCurrentQuickOrdersCount(int count) {
    _currentQuickOrdersCount = count;
    notifyListeners();
  }

  int get currentOrdersCount => _currentOrdersCount;

  int get currentQuickOrdersCount => _currentQuickOrdersCount;
}
