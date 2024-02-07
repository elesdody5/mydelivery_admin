import 'package:core/domain/result.dart';

import '../../../../domain/model/debt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _fireStore;

  FirebaseService() : _fireStore = FirebaseFirestore.instance;

  Future<Result<List<Debt>>> getAllDebts() async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      final debtsDocs = await debtsCollection.get();
      final debts = debtsDocs.docs
          .map((doc) => Debt.fromJson(doc.data(), doc.id))
          .toList();
      return Success(debts);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result> addDebt(Debt debt) async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      debtsCollection.add(debt.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result> removeDebt(String? id) async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      await debtsCollection.doc(id).delete();
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
