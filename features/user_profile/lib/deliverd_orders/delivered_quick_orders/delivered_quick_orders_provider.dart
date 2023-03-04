import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';

import 'package:flutter/material.dart';
import 'package:user_profile/data/repository/user_repository_imp.dart';

import '../../data/repository/user_repository.dart';

class DeliveredQuickOrdersProvider extends BaseProvider {
  final UserRepository _repository;
  List<QuickOrder> filteredOrders = [];
  List<QuickOrder> _orders = [];
  void Function(int)? updateDeliveredQuickOrderCount;
  bool? inCityFilter;

  DeliveredQuickOrdersProvider(
      {UserRepository? deliveryRepository,
      this.updateDeliveredQuickOrderCount})
      : _repository = deliveryRepository ?? UserRepositoryImp();

  Future<void> getDeliveredDeliveryOrders(String userId) async {
    Result<List<QuickOrder>> result =
        await _repository.getDeliveredQuickOrders(userId);
    if (result.succeeded()) {
      _orders = result.getDataIfSuccess();
      filteredOrders = [..._orders];
      if (updateDeliveredQuickOrderCount != null) {
        updateDeliveredQuickOrderCount!(_orders.length);
      }
      notifyListeners();
    }
  }

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

  // void updateOrdersStatus() async {
  //   isLoading.value = true;
  //   List<String> ordersId = _orders.map((order) => order.id ?? "").toList();
  //   await _repository.updateQuickOrdersStatus(ordersId);
  //   isLoading.value = false;
  //   filteredOrders.clear();
  //   if (updateDeliveredQuickOrderCount != null) {
  //     updateDeliveredQuickOrderCount!(_orders.length);
  //   }
  //   notifyListeners();
  // }

  void filterWithCity(bool inCity) {
    inCityFilter = inCity;
    filteredOrders =
        _orders.where((element) => element.inCity == inCity).toList();
    notifyListeners();
  }
}
