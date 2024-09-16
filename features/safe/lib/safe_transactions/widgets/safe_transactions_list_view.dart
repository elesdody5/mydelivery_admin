import 'package:flutter/material.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:safe/safe_transactions/widgets/safe_transactions_list_item.dart';

class SafeTransactionsListView extends StatelessWidget {
  final List<SafeTransaction> transactions;

  const SafeTransactionsListView({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, __) => Divider(),
        itemCount: transactions.length,
        itemBuilder: (context, index) => ListTile(
              title: SafeTransactionsListItem(transaction: transactions[index]),
            ));
  }
}
