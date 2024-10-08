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
        if (transactions.isNotEmpty) {
          await Future(() => calculateTotalDebt(transactions));
        }
      }
    }
  }

  Future<void> addTransaction(TransactionType type, double amount,
      String reason, String deliveryName) async {
    if (addToDebt(type, amount)) {
      isLoading.value = true;
      await createTransaction(type, amount, reason, deliveryName);
      await _debtsRepository.updateDebt(debt);
      isLoading.value = false;
    } else {
      errorMessage.value = "error_deduction"
          .trParams({"amount": (debt.totalAmount ?? 0).toString()});
    }
    notifyListeners();
  }

  Future<void> removeTransaction(DebtTransaction transition) async {
    isLoading.value = true;
    Result result = await _debtsRepository.removeTransaction(transition.id);
    if (result.succeeded()) {
      transactions.remove(transition);
    }
    isLoading.value = false;
    notifyListeners();
  }

  bool addToDebt(TransactionType type, double amount) {
    switch (type) {
      case TransactionType.adding:
        debt.totalAmount = (debt.totalAmount ?? 0) + amount;
        debt.type = (debt.totalAmount ?? 0) > 0
            ? TransactionType.adding
            : TransactionType.deduction;
        return true;
      case TransactionType.deduction:
        debt.totalAmount = (debt.totalAmount ?? 0) - amount;
        debt.type = (debt.totalAmount ?? 0) > 0
            ? TransactionType.adding
            : TransactionType.deduction;
        return true;
    }
  }

  Future<void> createTransaction(TransactionType type, double amount,
      String reason, String deliveryName) async {
    final debtTransaction = DebtTransaction(
        transactionType: type,
        amount: amount,
        reason: reason,
        debtId: debt.id,
        deliveryName: deliveryName,
        createdAt: DateTime.now());

    Result result = await _debtsRepository.addDebtTransaction(debtTransaction);
    if (result.succeeded()) {
      transactions.insert(0, debtTransaction);
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }

  void calculateTotalDebt(List<DebtTransaction> transactions) {
    var total = 0.0;
    for (var transaction in transactions) {
      total = transaction.transactionType == TransactionType.adding
          ? total + (transaction.amount ?? 0)
          : total - (transaction.amount ?? 0);
    }
    debt.totalAmount = total;
    debt.type = total > 0 ? TransactionType.adding : TransactionType.deduction;
  }
}
