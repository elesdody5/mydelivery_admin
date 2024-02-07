import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:debts/debts/data/remote/firebase/firebase_service.dart';

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
  Future<Result> removeDebt(String? id) {
    return _firebaseService.removeDebt(id);
  }

  @override
  Future<Result> addDebts(Debt debt) async {
    User? admin = await _sharedPreferencesManager.getAdminDetails();
    debt.userAdded = admin;
    return _firebaseService.addDebt(debt);
  }
}
