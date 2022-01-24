import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/repository/auth_repository.dart';
import 'package:authentication/data/repository/repository.dart';
import 'package:authentication/domin/model/signup_model.dart';
import 'package:core/domain/result.dart';

abstract class SignupUseCase {
  Future<Result<LoginResponse>> invoke(SignUpModel signUpModel);
}

class SignupUseCasImp implements SignupUseCase {
  AuthRepository _repository;

  SignupUseCasImp({AuthRepository? authRepository})
      : _repository = authRepository ?? AuthRepositoryImp();

  @override
  Future<Result<LoginResponse>> invoke(SignUpModel signUpModel) async {
    return _repository.signUp(signUpModel);
  }
}
