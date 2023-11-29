import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/domin/auto_login_usecase/autologin_usecase.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';

class SplashProvider extends BaseProvider {
  AutoLoginUseCase _autoLoginUseCase;

  SplashProvider({AutoLoginUseCase? autoLoginUseCase})
      : _autoLoginUseCase = autoLoginUseCase ?? AutoLoginUseCaseImp();

  Future<void> autoLogin() async {
    LoginResponse? loginResponse = await _autoLoginUseCase.invoke();
    if (checkIfAdminOrSpecialUser(loginResponse)) {
      navigation.value = Destination(
          routeName: homeScreen,
          argument: loginResponse?.userPhone,
          removeFromStack: true);
    } else {
      navigation.value =
          Destination(routeName: loginScreenRouteName, removeFromStack: true);
    }
  }

  bool checkIfAdminOrSpecialUser(LoginResponse? loginResponse) {
    return loginResponse?.userType?.name == UserType.admin.name ||
        loginResponse?.userPhone == "01004404662" ||
        loginResponse?.userPhone == "01033723390" ||
        loginResponse?.userPhone == "01004733487";
  }
}
