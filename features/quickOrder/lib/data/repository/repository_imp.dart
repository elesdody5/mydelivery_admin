import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:core/const.dart';
import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';
import 'package:quickorder/data/repository/repository.dart';

import '../remote/remote_data_source.dart';
import '../remote/remote_data_source_im.dart';

class QuickOrderRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final SharedPreferencesManager _sharedPreferencesManager;

  QuickOrderRepository({RemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? RemoteDataSourceImp(),
        _sharedPreferencesManager = SharedPreferencesManagerImp();

  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) {
    return _remoteDataSource.sendQuickOrder(quickOrder);
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
    _sharedPreferencesManager.saveScheduleQuickOrder(quickOrder);
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(
        duration, quickOrder.hashCode, addQuickOrder);
  }

  @pragma('vm:entry-point')
  static void addQuickOrder() async {
    QuickOrder? quickOrder =
        await SharedPreferencesManagerImp().getScheduledQuickOrder();
    if (quickOrder != null) {
      RemoteDataSourceImp().sendQuickOrder(quickOrder);
    }
  }
}
