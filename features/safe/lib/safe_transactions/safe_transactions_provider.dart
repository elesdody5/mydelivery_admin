import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:safe/data/safe_repository_imp.dart';
import 'package:safe/domain/model/safe_transaction.dart';

import '../domain/safe_repository.dart';

class SafeTransactionsProvider extends BaseProvider {
  final SafeRepository _safeRepository;

  num total = 0;
  List<SafeTransaction> safeTransactions = [];

  SafeTransactionsProvider({SafeRepository? safeRepository})
      : _safeRepository = safeRepository ?? SafeRepositoryImp();

  Future<void> getSafeTransactions() async {
    var result = await _safeRepository.getSafeTransactions();
    if (result.succeeded()) {
      var (total, safeTransactions) = result.getDataIfSuccess();
      this.total = total;
      this.safeTransactions = safeTransactions;
      notifyListeners();
    }
  }

  Future<void> addTransaction(
      AddingType type, double amount, String reason) async {
    final safeTransaction =
        SafeTransaction(addingType: type, amount: amount, reason: reason);
    isLoading.value = true;
    Result<SafeTransaction> result =
        await _safeRepository.addSafeTransaction(safeTransaction);
    isLoading.value = false;
    if (result.succeeded()) {
      total = type == AddingType.adding ? total + amount : total - amount;
      safeTransactions.insert(0, result.getDataIfSuccess());
      notifyListeners();
    }
  }
}
