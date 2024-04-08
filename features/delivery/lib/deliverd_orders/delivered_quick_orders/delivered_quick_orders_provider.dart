import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DeliveredQuickOrdersProvider extends BaseProvider {
  final DeliveryRepository _repository;
  List<QuickOrder> filteredOrders = [];
  List<QuickOrder> _orders = [];
  void Function(int)? updateDeliveredQuickOrderCount;
  bool? inCityFilter;
  int? ordersCount;
  int? totalPrice;

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
      getOrdersCount();
      getTotalPrice();
      notifyListeners();
    }
  }

  void getOrdersCount() {
    var count = 0;
    for (var element in filteredOrders) {
      count += element.count ?? 1;
    }
    ordersCount = count;
  }

  void getTotalPrice() {
    totalPrice = filteredOrders.map((e) => e.price ?? 0).sum;
  }

  void dateFilter(DateTimeRange? dateTime) {
    filteredOrders = filteredOrders
        .where((element) => _inRange(element.dateTime, dateTime))
        .toList();
    getOrdersCount();
    getTotalPrice();
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
    List<String> ordersId = filteredOrders.map((order) => order.id ?? "").toList();
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

  Future<void> deleteQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.removeQuickOrder(quickOrder.id);
    if (result.succeeded()) {
      _orders.remove(quickOrder);
      filteredOrders = [..._orders];
    } else {
      errorMessage.value = "something_went_wrong";
    }
    isLoading.value = false;
    notifyListeners();
  }

  void updateQuickOrderInList(QuickOrder? quickOrder) {
    if (quickOrder != null) {
      int index = _orders.indexWhere((element) => element.id == quickOrder.id);
      _orders[index] = quickOrder;
      filteredOrders = [..._orders];
      getOrdersCount();
      getTotalPrice();
      notifyListeners();
    }
  }
}
