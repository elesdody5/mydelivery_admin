import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';

abstract class UsersRepository {
  Future<void> addDelivery();
  Future<Result<List<User>>> getAllDelivery();
  Future<Result<List<User>>> getAllOwners();
}
