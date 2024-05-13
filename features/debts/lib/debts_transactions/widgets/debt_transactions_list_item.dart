import 'package:debts/domain/model/debts_transactions.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/utils.dart';
import 'package:get/get.dart';

class DebtTransactionListItem extends StatelessWidget {
  final DebtTransaction transaction;

  const DebtTransactionListItem({Key? key, required this.transaction})
      : super(key: key);

  IconData transactionIcon() {
    return transaction.transactionType == TransactionType.deduction
        ? Icons.arrow_upward_outlined
        : Icons.arrow_downward_outlined;
  }

  Color transactionColor() {
    return transaction.transactionType == TransactionType.deduction
        ? Colors.green
        : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Get.theme.primaryColor),
          child: Icon(transactionIcon(), color: transactionColor()),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.createdAt?.customFormat() ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              transaction.createdAt?.timeFormat() ?? "",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.reason ?? "",
            ),
            Text(
              transaction.userAdded?.name ?? "",
              style: const TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${transaction.amount?.toString() ?? ""} ${"le".tr}",
              style: TextStyle(color: transactionColor()),
            ),
            Text(
              "${transaction.transactionType?.name.tr}",
              style: TextStyle(color: transactionColor()),
            ),
          ],
        ));
  }
}
