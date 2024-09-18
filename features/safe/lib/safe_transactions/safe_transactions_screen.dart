import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:safe/safe_transactions/safe_transactions_provider.dart';
import 'package:safe/safe_transactions/widgets/safe_transactions_list_view.dart';
import 'package:safe/safe_transactions/widgets/transaction_dialog.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SafeTransactionsScreen extends StatelessWidget {
  const SafeTransactionsScreen({super.key});

  void _showTransactionDialog(
      SafeTransactionsProvider provider, AddingType type) {
    Get.dialog(TransactionDialog(
        addTransaction: (amount, reason, deliveryName) =>
            provider.addTransaction(type, double.parse(amount), reason)));
  }

  void _setupListener(SafeTransactionsProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SafeTransactionsProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
      appBar: AppBar(
        title: Text("safe".tr),
      ),
      body: FutureWithLoadingProgress(
          future: provider.getSafeTransactions,
          child: Consumer<SafeTransactionsProvider>(
              builder: (_, provider, child) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "${"total_money".tr} ${((provider.total))} ${"le".tr}",
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: SafeTransactionsListView(
                              transactions: provider.safeTransactions),
                        ),
                        OverflowBar(
                          alignment: MainAxisAlignment.end,
                          overflowAlignment: OverflowBarAlignment.center,
                          spacing: 10,
                          children: [
                            ElevatedButton(
                                onPressed: () => _showTransactionDialog(
                                    provider, AddingType.adding),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width / 6),
                                  child: Text("adding".tr),
                                )),
                            ElevatedButton(
                                onPressed: () => _showTransactionDialog(
                                    provider, AddingType.deduction),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width / 6),
                                  child: Text("deduct".tr),
                                )),
                          ],
                        )
                      ],
                    ),
                  ))),
    );
  }
}
