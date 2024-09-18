import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';
import 'package:safe/data/remote/safe_service.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:safe/domain/safe_repository.dart';

class SafeRepositoryImp implements SafeRepository {
  final SafeService _safeService;
  final SharedPreferencesManager _preferencesManager;

  SafeRepositoryImp(
      {SafeService? safeService, SharedPreferencesManager? preferences})
      : _safeService = safeService ?? SafeService(),
        _preferencesManager = preferences ?? SharedPreferencesManagerImp();

  Result<T> _getResultFromResponse<T>(ApiResponse apiResponse) {
    try {
      if (apiResponse.errorMessage != null) {
        return Error(ApiException(apiResponse.errorMessage!));
      } else {
        return Success(apiResponse.responseData);
      }
    } catch (error) {
      print("auth api error $error");
      return Error(ApiException("Something went wrong"));
    }
  }

  @override
  Future<Result<(num, List<SafeTransaction>)>> getSafeTransactions() async {
    var response = await _safeService.getSafeTransactions();
    return _getResultFromResponse(response);
  }

  @override
  Future<Result<SafeTransaction>> addSafeTransaction(SafeTransaction safeTransactions) async {
    var userId = await _preferencesManager.getAdminId();
    safeTransactions.userAdded = User(id: userId);
    var response = await _safeService.addSafeTransaction(safeTransactions);
    return _getResultFromResponse(response);
  }
}
