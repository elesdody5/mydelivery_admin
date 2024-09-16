import 'package:core/domain/result.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/response.dart';
import 'package:safe/data/remote/safe_service.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:safe/domain/safe_repository.dart';

class SafeRepositoryImp implements SafeRepository {
  final SafeService _safeService;

  SafeRepositoryImp({SafeService? safeService})
      : _safeService = safeService ?? SafeService();

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
  Future<Result<(num, List<SafeTransaction>)>> getSafeTransactions() async{
   var response = await  _safeService.getSafeTransactions();
   return _getResultFromResponse(response);
  }
}
