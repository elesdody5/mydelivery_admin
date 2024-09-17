import 'package:flutter/material.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:get/get.dart';
import 'package:safe/safe_transactions/widgets/safe_transaction_details.dart';
import 'package:widgets/user_avatar.dart';

class SafeTransactionsListItem extends StatelessWidget {
  final SafeTransaction transaction;

  const SafeTransactionsListItem({super.key, required this.transaction});

  Color amountColor(AddingType? addingType) =>
      addingType == AddingType.adding ? Colors.green : Colors.red;

  String sign(AddingType? addingType) =>
      addingType == AddingType.adding ? "" : "-";

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        // onTap: ()=>Get.dialog(SafeTransactionDetails(transaction: transaction)),
        leading: UserAvatar(
            id: transaction.delivery?.id ?? "",
            imageUrl: transaction.delivery?.imageUrl),
        title: Text(transaction.delivery?.name ?? ""),
        subtitle: Text(
          "${"added_by".tr}: ${transaction.userAdded?.name ?? ""}",
          style: Get.textTheme.bodySmall,
          overflow: TextOverflow.clip,
        ),
        trailing: Column(
          children: [
            Text(
              "${sign(transaction.addingType)} ${transaction.amount?.toString() ?? ""}",
              style: Get.textTheme.bodyMedium
                  ?.copyWith(color: amountColor(transaction.addingType)),
            ),
            Text(transaction.transactionType?.name.toLowerCase().tr ?? "")
          ],
        ),
      ),
    );
  }
}
