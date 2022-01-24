import 'package:core/domain/user_type.dart';

class LoginResponse {
  String? token;
  String? userId;
  UserType? userType;

  LoginResponse(
      {required this.token, required this.userType, required this.userId});
}
