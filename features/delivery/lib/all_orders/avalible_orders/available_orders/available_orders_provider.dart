import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:core/screens.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AvailableOrdersProvider extends BaseProvider {
  List<User?> users = [];
  final DeliveryRepository _repository;
  List<Order> orders = [];
  void Function(int)? updateAvailableOrderCount;

  AvailableOrdersProvider(
      {DeliveryRepository? repository, this.updateAvailableOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  void getAvailableOrders() {
    Stream<List<Order>> ordersStream = _repository.getAvailableOrders();
    ordersStream.listen((orders) {
      this.orders = orders;
      users = orders.map((order) => order.user).toSet().toList();
      if (updateAvailableOrderCount != null) {
        updateAvailableOrderCount!(users.length);
      }
      notifyListeners();
    });
  }

  void navigateToUserOrderDetails(String userId) {
    List<Order> selectedOrders =
        orders.where((element) => element.user?.id == userId).toList();
    navigation.value = Destination(
        routeName: availableOrderDetailsScreen, argument: selectedOrders);
  }
}
