import 'package:flutter/material.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:get/get.dart';
import 'package:core/utils/utils.dart';

class SafeTransactionsListItem extends StatelessWidget {
  final SafeTransaction transaction;

  const SafeTransactionsListItem({super.key, required this.transaction});

  IconData transactionIcon() {
    return transaction.addingType == AddingType.adding
        ? Icons.arrow_upward_outlined
        : Icons.arrow_downward_outlined;
  }

  Color transactionColor() {
    return transaction.addingType == AddingType.adding
        ? Colors.green
        : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the horizontal padding
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
              "${"added_by".tr}: ${transaction.userAdded?.name ?? ""}",
              style: Get.textTheme.bodySmall,
            ),
            if (transaction.delivery?.name != null)
              Text(
                "${"delivery".tr}: ${transaction.delivery?.name ?? ""}",
                style: Get.textTheme.bodySmall,
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${transaction.amount?.toString() ?? ""} ${"le".tr}",
              style: TextStyle(color: transactionColor()),
            ),
            if (transaction.transactionType != null)
              Text(
                transaction.transactionType?.name.tr ?? "",
              ),
            if (transaction.reason != null)
              Text(
                transaction.reason?? "",
              ),
          ],
        ));
  }
}
