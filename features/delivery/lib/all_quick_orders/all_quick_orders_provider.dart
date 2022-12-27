import 'dart:isolate';

import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/order_status.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:flutter/foundation.dart';

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
      await _filterQuickOrders(allQuickOrders);
      _updateCount();
    } else {
      errorMessage.value = result.getErrorMessage();
    }
    isLoading.value = false;
    notifyListeners();
  }

  Future<void> _filterQuickOrders(List<QuickOrder> allQuickOrders) async {
    availableQuickOrders =
        await compute(_filterAvailableQuickOrders, allQuickOrders);
    withDeliveryQuickOrders =
        await compute(_filterWithDeliveryQuickOrders, allQuickOrders);
    deliveredQuickOrders =
        await compute(_filterDeliveredQuickOrders, allQuickOrders);
  }

  void _updateCount() {
    availableQuickOrdersCount = availableQuickOrders.length;
    withDeliveryQuickOrdersCount = withDeliveryQuickOrders.length;
    deliveredQuickOrdersCount = deliveredQuickOrders.length;
  }
}

Future<List<QuickOrder>> _filterAvailableQuickOrders(
    List<QuickOrder> allQuickOrders) async {
  return allQuickOrders
      .where((quickOrder) =>
          quickOrder.delivery == null &&
          quickOrder.orderStatus != OrderStatus.delivered)
      .toList();
}

Future<List<QuickOrder>> _filterWithDeliveryQuickOrders(
    List<QuickOrder> allQuickOrders) async {
  return allQuickOrders
      .where((quickOrder) =>
          quickOrder.delivery != null &&
          quickOrder.orderStatus != OrderStatus.delivered)
      .toList();
}

Future<List<QuickOrder>> _filterDeliveredQuickOrders(
    List<QuickOrder> allQuickOrders) async {
  return allQuickOrders
      .where((quickOrder) => quickOrder.orderStatus == OrderStatus.delivered)
      .toList();
}
