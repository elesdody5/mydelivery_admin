import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:core/const.dart';
import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';
import 'package:quickorder/data/local/entity/local_quick_order.dart';
import 'package:quickorder/data/local/entity/local_quick_order_table.dart';
import 'package:quickorder/data/local/quick_order_local_data_source.dart';
import 'package:quickorder/data/repository/repository.dart';

import '../remote/remote_data_source.dart';
import '../remote/remote_data_source_im.dart';

class QuickOrderRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final QuickOrderLocalDataSource _localDataSource;

  QuickOrderRepository(
      {RemoteDataSource? remoteDataSource,
      QuickOrderLocalDataSource? localDataSource})
      : _remoteDataSource = remoteDataSource ?? RemoteDataSourceImp(),
        _localDataSource = QuickOrderLocalDataSource();

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) async {
    Result result = await _remoteDataSource.sendQuickOrder(quickOrder);

    if (quickOrder.id != null && result.succeeded()) {
      _localDataSource
          .deleteQuickOrder(int.tryParse(quickOrder.id ?? "0") ?? 0);
    }
    return result;
  }

  @override
  Future<Result<List<Shop>>> getAllShops() {
    return _remoteDataSource.getAllShops();
  }

  @override
  Future<Result> updateQuickOrder(QuickOrder quickOrder) {
    return _remoteDataSource.updateQuickOrder(quickOrder);
  }

  @override
  Future<void> scheduleQuickOrder(
      Duration duration, QuickOrder quickOrder) async {
    int id =
        await _localDataSource.insertQuickOrder(quickOrder.toLocalQuickOrder());
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.oneShot(
      duration,
      id,
      addQuickOrder,
      exact: true,
    );
  }

  @pragma('vm:entry-point')
  static void addQuickOrder(int id) async {
    QuickOrderLocalDataSource localDataSource = QuickOrderLocalDataSource();
    LocalQuickOrder? localQuickOrder = await localDataSource.getQuickOrder(id);

    if (localQuickOrder != null) {
      QuickOrder quickOrder = localQuickOrder.toQuickOrder();
      Result result = await RemoteDataSourceImp().sendQuickOrder(quickOrder);
      if (result.succeeded()) {
        await localDataSource.deleteQuickOrder(id);
      }
    }
  }

  @override
  Future<Result<List<QuickOrder>>> getScheduledQuickOrder() async {
    List<LocalQuickOrder>? localQuickOrders =
        await _localDataSource.getScheduledQuickOrder();
    if (localQuickOrders != null) {
      return Success(localQuickOrders.map((e) => e.toQuickOrder()).toList());
    } else {
      return Success(List.empty());
    }
  }

  @override
  Future<void> deleteScheduledQuickOrder(QuickOrder quickOrder) async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.cancel(int.tryParse(quickOrder.id ?? "0") ?? 0);
    await _localDataSource
        .deleteQuickOrder(int.tryParse(quickOrder.id ?? "0") ?? 0);
  }
}
