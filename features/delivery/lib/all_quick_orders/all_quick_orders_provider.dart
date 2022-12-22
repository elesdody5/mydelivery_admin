import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order_status.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class AllQuickOrdersProvider extends BaseProvider {
  int availableQuickOrdersCount = 0;
  int withDeliveryQuickOrdersCount = 0;
  int deliveredQuickOrdersCount = 0;
  List<QuickOrder> availableQuickOrders = [];
  List<QuickOrder> withDeliveryQuickOrders = [];
  List<QuickOrder> deliveredQuickOrders = [];

  late DeliveryRepository _deliveryRepository;

  AllQuickOrdersProvider({DeliveryRepository? deliveryRepository}) {
    _deliveryRepository = deliveryRepository ?? DeliveryRepositoryImp();
  }

  Future<void> getAllQuickOrders() async {
    isLoading.value = true;
    Result result = await _deliveryRepository.getAllQuickOrders();
    if (result.succeeded()) {
      List<QuickOrder> allQuickOrders = result.getDataIfSuccess();
      availableQuickOrders = allQuickOrders
          .where((quickOrder) =>
              quickOrder.delivery == null &&
              quickOrder.orderStatus != OrderStatus.delivered)
          .toList();
      withDeliveryQuickOrders = allQuickOrders
          .where((quickOrder) =>
              quickOrder.delivery != null &&
              quickOrder.orderStatus != OrderStatus.delivered)
          .toList();
      deliveredQuickOrders = allQuickOrders
          .where(
              (quickOrder) => quickOrder.orderStatus == OrderStatus.delivered)
          .toList();
      availableQuickOrdersCount = availableQuickOrders.length;
      withDeliveryQuickOrdersCount = withDeliveryQuickOrders.length;
      deliveredQuickOrdersCount = deliveredQuickOrders.length;
    } else {
      errorMessage.value = result.getErrorMessage();
    }
    isLoading.value = false;
    notifyListeners();
  }
}
