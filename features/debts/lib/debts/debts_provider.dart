import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:debts/debts/data/debts_repository_imp.dart';
import 'package:debts/domain/debts_repository.dart';

import '../domain/model/debt.dart';

class DebtsProvider extends BaseProvider {
  List<Debt> debts = [];
  final DebtsRepository _repository;

  DebtsProvider({DebtsRepository? repository})
      : _repository = repository ?? DebtsRepositoryImp();

  Future<void> getAllDebts() async {
    Result<List<Debt>> result = await _repository.getAllDebts();
    if (result.succeeded()) {
      debts = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> addDebt(Debt debt) async {
    isLoading.value = true;
    Result result = await _repository.addDebts(debt);
    isLoading.value = false;
    if (result.succeeded()) {
      debts.add(debt);
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }

  Future<void> removeDebt(Debt debt) async {
    isLoading.value = true;
    Result result = await _repository.removeDebt(debt.id);
    isLoading.value = true;
    if (result.succeeded()) {
      debts.remove(debt);
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
}
