
import 'package:authentication/data/model/login_response.dart';
import 'package:authentication/data/repository/auth_repository.dart';
import 'package:authentication/data/repository/repository.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user_type.dart';

abstract class AutoLoginUseCase {
  Future<LoginResponse?> invoke();
}

class AutoLoginUseCaseImp implements AutoLoginUseCase {
  AuthRepository _authRepository;

  AutoLoginUseCaseImp({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImp();

  @override
  Future<LoginResponse?> invoke() async {
    Result<LoginResponse> loginResponse = await _authRepository.autoLogin();
    if (loginResponse.succeeded())
      return loginResponse.getDataIfSuccess();
    return null;
  }
}
