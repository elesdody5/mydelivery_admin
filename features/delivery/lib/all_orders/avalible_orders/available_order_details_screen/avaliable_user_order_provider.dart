import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';


class AvailableUserOrdersDetailsProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<Order> orders = [];

  AvailableUserOrdersDetailsProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();

  set(List<Order> orders) => this.orders = orders;

  Future<void> addDeliveryToOrders() async {
    isLoading.value = true;
    Result result = await _repository.addDeliveryToOrders(orders);
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "pick_order_success_message";
    } else {
      errorMessage.value = result.getErrorMessage();
    }
  }
}
