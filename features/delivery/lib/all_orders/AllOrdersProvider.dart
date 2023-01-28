import 'package:core/base_provider.dart';

class AllOrdersProvider extends BaseProvider {
  int availableOrdersCount = 0;
  int withDeliveryOrdersCount = 0;
  int deliveredOrdersCount = 0;

  void setAvailableOrdersCount(int count) {
    availableOrdersCount = count;
    notifyListeners();
  }

  void setWithDeliveryOrdersCount(int count) {
    withDeliveryOrdersCount = count;
    notifyListeners();
  }

  void setDeliveredOrdersCount(int count) {
    deliveredOrdersCount = count;
    notifyListeners();
  }
}
