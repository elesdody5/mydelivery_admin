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
    UserType? userType = await _autoLoginUseCase.invoke();
    print(userType);
    switch (userType) {
      case UserType.admin:
        navigation.value =
            Destination(routeName: homeScreen, removeFromStack: true);
        break;
      default:
        navigation.value =
            Destination(routeName: loginScreenRouteName, removeFromStack: true);
        break;
    }
  }
}
