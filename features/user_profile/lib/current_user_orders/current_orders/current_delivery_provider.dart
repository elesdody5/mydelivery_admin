import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:user_profile/data/repository/user_repository.dart';
import 'package:user_profile/data/repository/user_repository_imp.dart';

class CurrentUserOrdersProvider extends BaseProvider {
  final UserRepository _repository;
  List<ShopOrder> orders = [];
  void Function(int)? updateCurrentOrderCount;

  CurrentUserOrdersProvider(
      {UserRepository? repository, this.updateCurrentOrderCount})
      : _repository = repository ?? UserRepositoryImp();

  Future<void> getUserOrders(String userId) async {
    Stream<List<ShopOrder>> stream = _repository.getCurrentUserOrders(userId);
    stream.listen((event) {
      orders = event;
      if (updateCurrentOrderCount != null) {
        updateCurrentOrderCount!(orders.length);
      }
      notifyListeners();
    });
  }

// Future<void> updateOrderStatus(
//     OrderStatus orderStatus, String orderId) async {
//   await _repository.updateOrderStatus(orderId, orderStatus);
// }
}
