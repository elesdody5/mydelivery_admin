import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/model/reset_password_model.dart';
import 'package:authentication/data/remote/auth_remote_data_source.dart';
import 'package:authentication/data/remote/auth_remote_data_source_imp.dart';
import 'package:authentication/data/repository/repository.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRemoteDataSource _remoteAuth;
  SharedPreferencesManager _userManager;

  AuthRepositoryImp(
      {AuthRemoteDataSource? remoteAuth, SharedPreferencesManager? userManager})
      : _remoteAuth = remoteAuth ?? AuthRemoteDataSourceImp(),
        _userManager = userManager ?? SharedPreferencesManagerImp();

  @override
  Future<Result<LoginResponse>> login(String phone, String password) async {
    Result<LoginResponse> loginResponse =
        await _remoteAuth.login(phone, password);
    if (loginResponse.succeeded()) {
      var loginData = loginResponse.getDataIfSuccess();
      await _userManager.saveUserPhone(phone);
      await _userManager.saveUserPassword(password);
      await _userManager.saveToken(loginData.token);
      await _userManager.saveUserId(loginData.userId);
      await _userManager.saveUserType(loginData.userType);
    }
    return loginResponse;
  }

  @override
  Future<Result<LoginResponse>> signUp(SignUpModel signUpModel) async {
    Result<LoginResponse> loginResponse = await _remoteAuth.signUp(signUpModel);
    if (loginResponse.succeeded()) {
      var loginData = loginResponse.getDataIfSuccess();
      await _saveUserInfo(loginData);
      _remoteAuth.addInterceptor(loginData.token ?? "");
    }
    return loginResponse;
  }

  Future<void> _saveUserInfo(LoginResponse loginData) async {
    await _userManager.saveToken(loginData.token);
    await _userManager.saveUserId(loginData.userId);
    await _userManager.saveUserType(loginData.userType);
  }

  @override
  Future<Result<String>> forgetPassword(String email) async {
    return await _remoteAuth.forgetPassword(email);
  }

  @override
  Future<void> logout() async {
    String id = await _userManager.getUserId() ?? "";
    await _remoteAuth.clearNotificationToken(id);
    await _userManager.deleteUserData();
  }

  @override
  Future<String> getLang() {
    return _userManager.getLocal();
  }

  @override
  Future<Result<LoginResponse>> autoLogin() async {
    String? password = await _userManager.getUserPassword();
    String? phone = await _userManager.getUserPhone();
    if (phone != null && password != null) return await login(phone, password);
    return Error(Exception("user not found"));
  }

  @override
  Future<void> saveNotificationToken(String? notificationToken) async {
    String? saveNotificationToken = await _userManager.getNotificationToken();
    String? userId = await _userManager.getUserId();
    if (notificationToken != saveNotificationToken) {
      await _userManager.saveNotificationToken(notificationToken);
      await _remoteAuth.updateNotificationToken(userId, notificationToken);
    }
  }

  @override
  Future<Result<bool>> updatePassword(
      String oldPassword, String newPassword, String confirmPassword) {
    return _remoteAuth.updatePassword(
        oldPassword, newPassword, confirmPassword);
  }

  @override
  Future<Result<String>> resetPassword(ResetPasswordModel resetPasswordModel) {
    return _remoteAuth.resetPassword(resetPasswordModel);
  }
}
