import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';
import 'package:dashboard/domain/model/debt.dart';

class DebtsProvider extends BaseProvider {
  List<Debt> debts = [];
  final Repository _repository;

  DebtsProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

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
