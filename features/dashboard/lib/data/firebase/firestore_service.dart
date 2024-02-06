import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';
import 'package:core/model/order_settings.dart';
import 'package:dashboard/domain/model/debt.dart';

abstract class FireStoreService {
  Future<Result> updateOrderSettings(OrderSettings settings);

  Future<Result<OrderSettings>> getOrderSettings();

  Future<Result<List<City>>> getCities();

  Future<Result> addNewCity(City city);

  Future<Result> addDebt(Debt debt);

  Future<Result> updateCity(City city);

  Future<Result<List<Debt>>> getAllDebts();

  Future<Result> removeDebt(String? id);
}
