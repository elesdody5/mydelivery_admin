import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/model/debt.dart';

class DebtsListItem extends StatelessWidget {
  final Debt debt;
  final Function(Debt)? onLongPress;
  final Function(Debt) onTap;

  const DebtsListItem(
      {Key? key, required this.debt, required this.onTap, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(debt),
      onLongPress: () => onLongPress?.call(debt),
      title: Text(debt.title ?? ""),
      subtitle: Text(
        debt.userAdded?.name ?? "",
        style: const TextStyle(color: Colors.redAccent),
      ),
      trailing: Text(
        "${debt.totalAmount?.toString() ?? ""} ${"le".tr}",
      ),
    );
  }
}
