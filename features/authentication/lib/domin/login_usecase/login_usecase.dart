import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/repository/auth_repository.dart';
import 'package:authentication/data/repository/repository.dart';
import 'package:core/domain/result.dart';

abstract class LoginUseCase {
  Future<Result<LoginResponse>> invoke(String phone, String password);
}

class LoginUseCaseImp implements LoginUseCase {
  AuthRepository _authRepository;

  LoginUseCaseImp(
      {AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImp();

  @override
  Future<Result<LoginResponse>> invoke(String phone, String password) async {
    Result<LoginResponse> result = await _authRepository.login(phone, password);
    return result;
  }
}
