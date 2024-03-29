import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';

abstract class SharedPreferencesManager {
  Future<void> deleteUserData();

  Future<void> saveToken(String? token);

  Future<String?> getToken();

  Future<UserType?> getUserType();

  Future<void> saveUserType(UserType? userType);

  Future<void> saveLocal(String local);

  Future<String> getLocal();

  Future<void> saveNotificationToken(String? notificationToken);

  Future<String?> getNotificationToken();

  Future<void> saveUserId(String? userId);

  Future<void> saveAdminId(String? userId);

  Future<String?> getUserId();

  Future<String?> getAdminId();

  Future<User?> getUserDetails();

  Future<User?> getAdminDetails();

  Future<void> saveUserDetails(User user);

  Future<void> saveAdminDetails(User user);

  Future<void> saveVendorShopId(String shopId);

  Future<String?> getVendorShopId();

  Future<void> saveUserPhone(String phone);

  Future<void> saveUserPassword(String password);

  Future<String?> getUserPhone();

  Future<String?> getUserPassword();
}
