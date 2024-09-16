import 'package:flutter/material.dart';
import 'package:safe/safe_transactions/safe_transactions_provider.dart';
import 'package:safe/safe_transactions/widgets/safe_transactions_list_view.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SafeTransactionsScreen extends StatelessWidget {
  const SafeTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SafeTransactionsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("safe".tr),
      ),
      body: FutureWithLoadingProgress(
          future: provider.getSafeTransactions,
          child: Consumer<SafeTransactionsProvider>(
              builder: (_, provider, child) => SafeTransactionsListView(
                  transactions: provider.safeTransactions))),
    );
  }
}
