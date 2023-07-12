import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';

abstract class Repository {
  Future<Result> sendQuickOrder(QuickOrder quickOrder);

  Future<Result<List<Shop>>> getAllShops();

  Future<Result> updateQuickOrder(QuickOrder quickOrder);

  Future<void> scheduleQuickOrder(Duration duration, QuickOrder quickOrder);

  Future<Result<List<QuickOrder>>> getScheduledQuickOrder();

  Future<void> deleteScheduledQuickOrder(QuickOrder quickOrder);
}
