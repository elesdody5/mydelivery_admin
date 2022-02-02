import 'package:core/domain/result.dart';
import 'package:dashboard/domain/model/order_settings.dart';

abstract class FireStoreService {

  Future<Result> updateOrderSettings(OrderSettings settings);

  Future<Result<OrderSettings>> getOrderSettings();
}
