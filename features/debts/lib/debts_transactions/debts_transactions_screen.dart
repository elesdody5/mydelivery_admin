import 'package:core/utils/utils.dart';
import 'package:debts/debts_transactions/debts_transactions_provider.dart';
import 'package:debts/debts_transactions/widgets/debts_transactions_list.dart';
import 'package:debts/debts_transactions/widgets/transaction_dialog.dart';
import 'package:debts/domain/model/debt.dart';
import 'package:debts/domain/model/debts_transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DebtsTransactionsScreen extends StatelessWidget {
  const DebtsTransactionsScreen({Key? key}) : super(key: key);

  void _showTransactionDialog(
      DebtsTransactionsProvider provider, TransactionType type) {
    Get.dialog(TransactionDialog(
        addTransaction: (amount, reason) =>
            provider.addTransaction(type, double.parse(amount), reason)));
  }

  void _setupListener(DebtsTransactionsProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
  }

  Color amountColor(TransactionType? type) {
    return type == TransactionType.adding ? Colors.red : Colors.green;
  }

  void _showAlertDialog(
      DebtsTransactionsProvider provider, DebtTransaction transaction) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.removeTransaction(transaction);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    Debt debt = Get.arguments;
    final provider =
        Provider.of<DebtsTransactionsProvider>(context, listen: false);
    _setupListener(provider);
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: provider.debt);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(debt.title ?? ""),
        ),
        body: FutureWithLoadingProgress(
          future: () => provider.getTransactions(debt),
          child: Consumer<DebtsTransactionsProvider>(
            builder: (_, provider, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "${((debt.totalAmount ?? 0) * -1)} ${"le".tr}",
                    style: TextStyle(color: amountColor(debt.type)),
                  ),
                  subtitle: debt.createdAt != null
                      ? Text(debt.createdAt?.customFormat() ?? "")
                      : null,
                  trailing: debt.phone != null
                      ? InkWell(
                          onTap: () => launch("tel://${debt.phone}"),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.phone,
                              color: Get.theme.primaryIconTheme.color,
                            ),
                          ),
                        )
                      : null,
                ),
                Expanded(
                    child: DebtsTransactionsList(
                  transactions: provider.transactions,
                  onLongPress: (transaction) =>
                      _showAlertDialog(provider, transaction),
                )),
                ButtonBar(
                  buttonPadding: const EdgeInsets.all(10),
                  mainAxisSize: MainAxisSize.max,
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => _showTransactionDialog(
                            provider, TransactionType.adding),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width / 6),
                          child: Text("adding_debt".tr),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red)),
                    ElevatedButton(
                        onPressed: () => _showTransactionDialog(
                            provider, TransactionType.deduction),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width / 6),
                          child: Text("nondeductible".tr),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
