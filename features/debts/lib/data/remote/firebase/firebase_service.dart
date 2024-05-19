import 'package:core/domain/result.dart';
import 'package:debts/domain/model/debts_transactions.dart';

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
      print(e);
      return Error(e);
    }
  }

  Future<Result<String>> addDebt(Debt debt) async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      final result = await debtsCollection.add(debt.toJson());
      return Success(result.id);
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

  Future<Result> updateDebt(Debt debt) async {
    try {
      final debtDoc = _fireStore.collection('debts').doc(debt.id);
      await debtDoc.update(debt.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<List<DebtTransaction>>> getDebtTransactions(
      String debtId) async {
    try {
      final debtsTransactionsCollection =
          _fireStore.collection('debtsTransactions');
      final transactionsDocs = await debtsTransactionsCollection
          .where("debt_id", isEqualTo: debtId)
          .orderBy("created_at", descending: true)
          .get();
      final transactions = transactionsDocs.docs
          .map((doc) => DebtTransaction.fromJson(doc.data(), doc.id))
          .toList();
      return Success(transactions);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result> addDebtTransaction(DebtTransaction debtTransaction) async {
    try {
      final debtsTransactions = _fireStore.collection('debtsTransactions');
      await debtsTransactions.add(debtTransaction.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result> removeDebtTransactions(String? debtId) async {
    try {
      final debtsTransactions = await _fireStore
          .collection('debtsTransactions')
          .where("debt_id", isEqualTo: debtId)
          .get();
      WriteBatch batch = _fireStore.batch();
      for (var element in debtsTransactions.docs) {
        batch.delete(element.reference);
      }
      await batch.commit();
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result> removeTransaction(String? transactionId) async {
    try {
      final debtsCollection = _fireStore.collection('debtsTransactions');
      await debtsCollection.doc(transactionId).delete();
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
