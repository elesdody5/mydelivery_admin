import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:flutter/material.dart';

class DeliveredQuickOrdersProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> filteredOrders = [];
  List<QuickOrder> _orders = [];
  void Function(int)? updateDeliveredQuickOrderCount;
  bool? inCityFilter;
  int? ordersCount;

  DeliveredQuickOrdersProvider(
      {DeliveryRepository? deliveryRepository,
      this.updateDeliveredQuickOrderCount})
      : _repository = deliveryRepository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredDeliveryOrders(String deliveryId) async {
    Result<List<QuickOrder>> result =
        await _repository.getDeliveredQuickOrders(deliveryId);
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredOrders = [..._orders];
      if (updateDeliveredQuickOrderCount != null) {
        updateDeliveredQuickOrderCount!(_orders.length);
      }
      notifyListeners();
    }
  }

  // void getOrdersCount() {
  //   var list = filteredOrders.where((element) => (element.count ?? 0) > 1);
  //   ordersCount = filteredOrders.length +
  // }

  void dateFilter(DateTimeRange? dateTime) {
    filteredOrders = filteredOrders
        .where((element) => _inRange(element.dateTime, dateTime))
        .toList();
    notifyListeners();
  }

  bool _inRange(DateTime? day, DateTimeRange? range) {
    if (day == null || range == null) return false;

    DateTime startTime = range.start;
    DateTime endTime = range.end;

    if (_compareDates(day, startTime)) return true;
    if (_compareDates(day, endTime)) return true;

    return day.isAfter(startTime) && day.isBefore(endTime);
  }

  bool _compareDates(DateTime? firstDay, DateTime? secondDay) {
    return firstDay?.year == secondDay?.year &&
        firstDay?.month == secondDay?.month &&
        firstDay?.day == secondDay?.day;
  }

  void updateOrdersStatus() async {
    isLoading.value = true;
    List<String> ordersId = _orders.map((order) => order.id ?? "").toList();
    await _repository.updateQuickOrdersStatus(ordersId);
    isLoading.value = false;
    filteredOrders.clear();
    if (updateDeliveredQuickOrderCount != null) {
      updateDeliveredQuickOrderCount!(_orders.length);
    }
    notifyListeners();
  }

  void filterWithCity(bool inCity) {
    inCityFilter = inCity;
    filteredOrders =
        _orders.where((element) => element.inCity == inCity).toList();
    notifyListeners();
  }
}
