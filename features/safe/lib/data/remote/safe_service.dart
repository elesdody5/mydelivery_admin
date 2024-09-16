import 'package:core/data/remote/network_service.dart';
import 'package:core/model/response.dart';
import 'package:dio/dio.dart';
import 'package:safe/data/remote/apis_url.dart';
import 'package:safe/domain/model/safe_transaction.dart';

class SafeService {
  final Dio _dio;

  SafeService({Dio? dio}) : _dio = dio ?? DioBuilder.getDio();

  Future<ApiResponse<(num, List<SafeTransaction>)>>
      getSafeTransactions() async {
    final response = await _dio.get(safeTransactionsUrl);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print("error message is ${response.data['message']}");
      return ApiResponse(errorMessage: response.data['message']);
    }
    var total = response.data["totalAmount"];
    List<SafeTransaction> transactions = [];
    response.data['transactions']
        .forEach((json) => transactions.add(SafeTransaction.fromJson(json)));
    return ApiResponse(responseData: (total, transactions));
  }
}
