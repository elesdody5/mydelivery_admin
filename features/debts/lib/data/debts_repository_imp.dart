import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:debts/data/remote/firebase/firebase_service.dart';
import 'package:debts/domain/model/debts_transactions.dart';

import '../../domain/debts_repository.dart';
import '../../domain/model/debt.dart';
import 'package:core/data/shared_preferences/shared_preferences_manager.dart';

class DebtsRepositoryImp implements DebtsRepository {
  final FirebaseService _firebaseService;
  final SharedPreferencesManager _sharedPreferencesManager;

  DebtsRepositoryImp(
      {FirebaseService? firebaseService,
      SharedPreferencesManager? sharedPreferencesManager})
      : _firebaseService = firebaseService ?? FirebaseService(),
        _sharedPreferencesManager =
            sharedPreferencesManager ?? SharedPreferencesManagerImp();

  @override
  Future<Result<List<Debt>>> getAllDebts() {
    return _firebaseService.getAllDebts();
  }

  @override
  Future<Result> removeDebt(String? id) async {
    await _firebaseService.removeDebt(id);
    return removeDebtTransactions(id);
  }

  @override
  Future<Result> removeTransaction(String? id) async {
    return _firebaseService.removeTransaction(id);
  }

  Future<Result> removeDebtTransactions(String? debtId) {
    return _firebaseService.removeDebtTransactions(debtId);
  }

  @override
  Future<Result<String>> addDebts(Debt debt) async {
    User? admin = await _sharedPreferencesManager.getAdminDetails();
    debt.userAdded = admin;
    return _firebaseService.addDebt(debt);
  }

  @override
  Future<Result<List<DebtTransaction>>> getDebtTransactions(String id) {
    return _firebaseService.getDebtTransactions(id);
  }

  @override
  Future<Result> addDebtTransaction(DebtTransaction debtTransaction) async {
    User? admin = await _sharedPreferencesManager.getAdminDetails();
    debtTransaction.userAdded = admin;
    return _firebaseService.addDebtTransaction(debtTransaction);
  }

  @override
  Future<Result> updateDebt(Debt debt) {
    return _firebaseService.updateDebt(debt);
  }
}
