import 'package:flutter/material.dart';
import 'package:safe/domain/model/safe_transaction.dart';
import 'package:get/get.dart';
import 'package:widgets/user_list/user_list_item/user_list_item.dart';

class SafeTransactionDetails extends StatelessWidget {
  final SafeTransaction transaction;

  const SafeTransactionDetails({super.key, required this.transaction});

  Color amountColor(AddingType? addingType) =>
      addingType == AddingType.adding ? Colors.green : Colors.red;

  String sign(AddingType? addingType) =>
      addingType == AddingType.adding ? "" : "-";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(transaction.transactionType?.name.tr ?? ""),
              Text(
                "${sign(transaction.addingType)} ${transaction.amount?.toString() ?? ""}",
                style: Get.textTheme.bodyMedium
                    ?.copyWith(color: amountColor(transaction.addingType)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "${"delivery".tr}: ${transaction.delivery?.name ?? ""} ",
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "${"added_by".tr}: ${transaction.userAdded?.name ?? ""} ",
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              " ${transaction.formattedDate}  ${transaction.formattedTime} ",
              textDirection: TextDirection.ltr,
              style: Get.textTheme.bodySmall,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("cancel".tr))
      ],
    );
  }
}
