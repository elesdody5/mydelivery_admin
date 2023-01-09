import 'package:core/base_provider.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllQuickOrdersProvider extends BaseProvider {
  int availableQuickOrdersCount = 0;
  int withDeliveryQuickOrdersCount = 0;
  int deliveredQuickOrdersCount = 0;

  void setAvailableQuickOrdersCount(int count) {
    availableQuickOrdersCount = count;
    notifyListeners();
  }

  void setWithDeliveryQuickOrdersCount(int count) {
    withDeliveryQuickOrdersCount = count;
    notifyListeners();
  }

  void setDeliveredQuickOrdersCount(int count) {
    deliveredQuickOrdersCount = count;
    notifyListeners();
  }
}
