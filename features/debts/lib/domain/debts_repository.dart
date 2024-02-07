import 'package:core/domain/result.dart';

import 'model/debt.dart';

abstract class DebtsRepository {
  Future<Result<List<Debt>>> getAllDebts();

  Future<Result> removeDebt(String? id);

  Future<Result> addDebts(Debt debt);
}
