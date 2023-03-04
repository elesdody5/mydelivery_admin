import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/order.dart';
import 'package:user_profile/data/model/update_password_model.dart';

abstract class UserRemoteDataSource {
  Future<Result<User>> getUserDetails(String userId);

  Future<Result> updateUser(User user);

  Future<Result> updatePassword(UpdatePasswordModel updatePasswordModel);

  Future<Result<List<QuickOrder>>> getCurrentQuickOrders(String userId);

  Future<Result<List<QuickOrder>>> getDeliveredQuickOrders(String userId) ;
}
