import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/model/debt.dart';

class DebtsListItem extends StatelessWidget {
  final Debt debt;
  final Function(Debt)? onLongPress;

  const DebtsListItem({Key? key, required this.debt, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => onLongPress?.call(debt),
      title: Text(debt.title ?? ""),
      subtitle: Text(
        debt.userAdded?.name ?? "",
        style: const TextStyle(color: Colors.redAccent),
      ),
      trailing: Text(
        "${debt.price?.toString() ?? ""} ${"le".tr}",
      ),
    );
  }
}
