import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/domin/forget_password_usecase/forget_password_usecase.dart';
import 'package:authentication/domin/login_usecase/login_usecase.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';
import 'package:get/get.dart';

class LoginProvider extends BaseProvider {
  LoginUseCase _loginUseCase;
  ForgetPasswordUseCase _forgetPasswordUseCase;

  LoginProvider(
      {LoginUseCase? loginUseCase,
      ForgetPasswordUseCase? forgetPasswordUseCase})
      : _loginUseCase = loginUseCase ?? LoginUseCaseImp(),
        _forgetPasswordUseCase =
            forgetPasswordUseCase ?? ForgetPasswordUseCaseImp();

  void _navigate(String phone, UserType? userType) {
    if (userType?.name == UserType.admin.name ||
        phone == "01004404662" ||
        phone == "01004733487") {
      navigation.value = Destination(
          routeName: homeScreen, argument: phone, removeFromStack: true);
    } else {
      errorMessage.value = "Not Admin user";
    }
  }

  Future<void> login(String? phone, String? password) async {
    if (phone != null && password != null) {
      isLoading.value = true;
      Result<LoginResponse> result =
          await _loginUseCase.invoke(phone, password);
      isLoading.value = false;
      if (result.succeeded()) {
        _navigate(phone, result.getDataIfSuccess().userType);
      } else if (result.isNetworkError()) {
        errorMessage.value = "network_error".tr;
      } else {
        errorMessage.value = result.getErrorMessage();
      }
    }
  }

  Future<void> forgetPassword(String? phone) async {
    if (phone?.isNotEmpty == true) {
      isLoading.value = true;
      Result result = await _forgetPasswordUseCase.invoke(phone!);
      isLoading.value = false;
      if (result.succeeded()) {
        successMessage.value = "forget_password_message_body";
      } else {
        errorMessage.value = result.getErrorMessage();
      }
    }
  }
}
