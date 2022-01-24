import 'package:core/base_provider.dart';

class AllAvailableOrdersProvider extends BaseProvider {
  int _availableQuickOrdersCount = 0;
  int _availableOrdersCount = 0;

  void setAvailableOrdersCount(int count) {
    _availableOrdersCount = count;
    notifyListeners();
  }

  void setAvailableQuickOrdersCount(int count) {
    _availableQuickOrdersCount = count;
    notifyListeners();
  }

  int get availableOrdersCount => _availableOrdersCount;

  int get availableQuickOrdersCount => _availableQuickOrdersCount;
}
