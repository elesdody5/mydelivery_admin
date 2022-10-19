import 'package:authentication/data/repository/auth_repository.dart';
import 'package:authentication/data/repository/repository.dart';
import 'package:core/domain/result.dart';

abstract class ForgetPasswordUseCase {
  Future<Result> invoke(String phone);
}

class ForgetPasswordUseCaseImp implements ForgetPasswordUseCase {
  final AuthRepository _repository;

  ForgetPasswordUseCaseImp({AuthRepository? repository})
      : _repository = repository ?? AuthRepositoryImp();

  @override
  Future<Result> invoke(String phone) {
    return _repository.forgetPassword(phone);
  }
}
