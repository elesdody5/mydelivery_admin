import 'package:core/domain/result.dart';
import 'package:safe/domain/model/safe_transaction.dart';

abstract class SafeRepository {
  Future<Result<(num, List<SafeTransaction>)>> getSafeTransactions();

  Future<Result<SafeTransaction>> addSafeTransaction(SafeTransaction safeTransactions);
}
