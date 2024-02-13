import 'dart:ffi';

import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:debts/data/debts_repository_imp.dart';
import 'package:debts/domain/debts_repository.dart';
import 'package:debts/domain/model/debts_transactions.dart';
import 'package:get/get.dart';
import '../domain/model/debt.dart';

class DebtsTransactionsProvider extends BaseProvider {
  final DebtsRepository _debtsRepository;
  List<DebtTransaction> transactions = [];
  late Debt debt;

  DebtsTransactionsProvider({DebtsRepository? debtsRepository})
      : _debtsRepository = debtsRepository ?? DebtsRepositoryImp();

  Future<void> getTransactions(Debt debt) async {
    this.debt = debt;
    if (debt.id != null) {
      Result<List<DebtTransaction>> result =
          await _debtsRepository.getDebtTransactions(debt.id!);
      if (result.succeeded()) {
        transactions = result.getDataIfSuccess();
      }
    }
  }

  Future<void> addTransaction(TransactionType type, double amount) async {
    if (addToDebt(type, amount)) {
      isLoading.value = true;
      await createTransaction(type, amount);
      await _debtsRepository.updateDebt(debt);
      isLoading.value = false;
    } else {
      errorMessage.value = "error_deduction"
          .trParams({"amount": (debt.totalAmount ?? 0).toString()});
    }
    notifyListeners();
  }

  bool addToDebt(TransactionType type, double amount) {
    switch (type) {
      case TransactionType.adding:
        debt.totalAmount = (debt.totalAmount ?? 0) + amount;
        return true;
      case TransactionType.deduction:
        return deductFromDebt(amount);
    }
  }

  bool deductFromDebt(double amount) {
    if (amount > (debt.totalAmount ?? 0)) {
      return false;
    } else {
      debt.totalAmount = (debt.totalAmount ?? 0) - amount;
      return true;
    }
  }

  Future<void> createTransaction(TransactionType type, double amount) async {
    final debtTransaction = DebtTransaction(
        transactionType: type,
        amount: amount,
        debtId: debt.id,
        createdAt: DateTime.now());

    Result result = await _debtsRepository.addDebtTransaction(debtTransaction);
    if (result.succeeded()) {
      transactions.insert(0, debtTransaction);
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
}
