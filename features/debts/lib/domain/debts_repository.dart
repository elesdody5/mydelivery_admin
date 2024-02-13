import 'package:core/domain/result.dart';
import 'package:debts/domain/model/debts_transactions.dart';

import 'model/debt.dart';

abstract class DebtsRepository {
  Future<Result<List<Debt>>> getAllDebts();

  Future<Result> removeDebt(String? id);

  Future<Result<String>> addDebts(Debt debt);

  Future<Result<List<DebtTransaction>>> getDebtTransactions(String id);

  Future<Result> addDebtTransaction(DebtTransaction debtTransaction);

  Future<Result> updateDebt(Debt debt);
}
