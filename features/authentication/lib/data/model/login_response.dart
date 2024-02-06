import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';

class LoginResponse {
  String? token;
  User? user;
  UserType? userType;
  String? userPhone;

  LoginResponse(
      {required this.token,
      required this.userType,
      required this.user,
      required this.userPhone});
}
