import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order_status.dart';
import 'package:user_profile/data/repository/user_repository.dart';
import 'package:user_profile/data/repository/user_repository_imp.dart';


class CurrentQuickOrderProvider extends BaseProvider {
  final UserRepository _repository;
  List<QuickOrder> orders = [];
  void Function(int)? updateCurrentQuickOrderCount;

  CurrentQuickOrderProvider(
      {UserRepository? deliveryRepository,
      this.updateCurrentQuickOrderCount})
      : _repository = deliveryRepository ?? UserRepositoryImp();

  Future<void> getCurrentDeliveryOrders(String userId) async {
    Result<List<QuickOrder>> result =
        await _repository.getCurrentUserQuickOrders(userId);
    if (result.succeeded()) {
      orders = result.getDataIfSuccess();
      if (updateCurrentQuickOrderCount != null) {
        updateCurrentQuickOrderCount!(orders.length);
      }
      notifyListeners();
    }
  }

}
