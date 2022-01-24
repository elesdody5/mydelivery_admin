import 'package:authentication/domin/model/signup_model.dart';
import 'package:authentication/domin/signup_usecase/signup_usecase.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';

class SignUpProvider extends BaseProvider {
  SignupUseCase _signupUseCase;
  SignUpModel signUpModel = SignUpModel();
  bool disableLocationButton = false;

  SignUpProvider({
    SignupUseCase? signupUseCase,
  }) : _signupUseCase = signupUseCase ?? SignupUseCasImp();

  Future<void> signUp() async {
    isLoading.value = true;
    Result result = await _signupUseCase.invoke(signUpModel);
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "sign_up_successfully";
    } else {
      errorMessage.value = result.getErrorMessage();
    }
  }

}
