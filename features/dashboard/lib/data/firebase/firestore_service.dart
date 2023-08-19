import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';
import 'package:dashboard/domain/model/order_settings.dart';

abstract class FireStoreService {

  Future<Result> updateOrderSettings(OrderSettings settings);

  Future<Result<OrderSettings>> getOrderSettings();

  Future<Result<List<City>>> getCities() ;

  Future<Result> addNewCity(City city) ;
  Future<Result> updateCity(City city) ;
}
