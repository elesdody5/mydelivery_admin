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
}
