import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';
import 'package:core/model/order_settings.dart';

abstract class FireStoreService {
  Future<Result<List<City>>> getCities() ;
  Future<Result<OrderSettings>> getOrderSettings();
}
