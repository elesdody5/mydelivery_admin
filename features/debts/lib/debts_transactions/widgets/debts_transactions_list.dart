import 'package:debts/debts_transactions/widgets/debt_transactions_list_item.dart';
import 'package:debts/domain/model/debts_transactions.dart';
import 'package:flutter/material.dart';

class DebtsTransactionsList extends StatelessWidget {
  final List<DebtTransaction> transactions;

  const DebtsTransactionsList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) =>
          DebtTransactionListItem(transaction: transactions[index]),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
    );
  }
}
