import 'package:core/base_provider.dart';
import 'package:core/domain/address.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';
import 'package:flutter/material.dart';

class AllDeliveredQuickOrdersProvider extends BaseProvider {
  List<QuickOrder> _orders = [];
  List<QuickOrder> filteredQuickOrders = [];
  final DeliveryRepository _repository;
  void Function(int)? updateDeliveredQuickOrderCount;

  AllDeliveredQuickOrdersProvider(
      {DeliveryRepository? repository, this.updateDeliveredQuickOrderCount})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getDeliveredQuickOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getAllDeliveredQuickOrders();
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredQuickOrders = [..._orders];
      if (updateDeliveredQuickOrderCount != null) {
        updateDeliveredQuickOrderCount!(_orders.length);
      }
      notifyListeners();
    }
  }

  void searchQuickOrder(String address) {
    filteredQuickOrders = _orders
        .where((order) => order.address?.contains(address) == true)
        .toList(growable: false);
    notifyListeners();
  }

  void dateFilter(DateTimeRange? dateTime) {
    filteredQuickOrders = filteredQuickOrders
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

  Future<void> deleteQuickOrder(QuickOrder quickOrder) async {
    isLoading.value = true;
    Result result = await _repository.removeQuickOrder(quickOrder.id);
    if (result.succeeded()) {
      _orders.remove(quickOrder);
      filteredQuickOrders = [..._orders];
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
      filteredQuickOrders = [..._orders];
      notifyListeners();
    }
  }
}
