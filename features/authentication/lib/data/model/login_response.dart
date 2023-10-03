import 'package:core/domain/user_type.dart';

class LoginResponse {
  String? token;
  String? userId;
  UserType? userType;
  String? userPhone;

  LoginResponse(
      {required this.token, required this.userType, required this.userId,required this.userPhone});
}
