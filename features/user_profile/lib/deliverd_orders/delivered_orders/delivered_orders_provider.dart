import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';

import 'package:flutter/material.dart';
import 'package:user_profile/data/repository/user_repository.dart';

import '../../data/repository/user_repository_imp.dart';

class DeliveredOrdersProvider extends BaseProvider {
  final UserRepository _repository;
  List<ShopOrder> filteredOrders = [];
  List<ShopOrder> _orders = [];
  void Function(int)? updateDeliveredOrderCount;

  DeliveredOrdersProvider(
      {UserRepository? repository, this.updateDeliveredOrderCount})
      : _repository = repository ?? UserRepositoryImp();

  Future<void> getDeliveredOrders(String userId) async {
    _orders = await _repository.getDeliveredOrdersForUser(userId);
    filteredOrders = [..._orders];
    if (updateDeliveredOrderCount != null) {
      updateDeliveredOrderCount!(filteredOrders.length);
    }
    notifyListeners();
  }

  int get totalDeliveryPrice {
    int total = 0;
    for (var order in filteredOrders) {
      total += order.deliveryPrice ?? 0;
    }
    return total;
  }

  get totalCoins {
    int total = 0;
    for (var order in filteredOrders) {
      total += order.coins ?? 0;
    }
    return total;
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
  //   List<String> ordersId =
  //       filteredOrders.map((order) => order.id ?? "").toList();
  //   await _repository.updateOrdersStatus(ordersId);
  //   isLoading.value = false;
  //   filteredOrders.clear();
  //   if (updateDeliveredOrderCount != null) {
  //     updateDeliveredOrderCount!(filteredOrders.length);
  //   }
  //   notifyListeners();
  // }
}
