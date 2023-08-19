import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';

abstract class FireStoreService {
  Future<Result<List<City>>> getCities() ;

}
