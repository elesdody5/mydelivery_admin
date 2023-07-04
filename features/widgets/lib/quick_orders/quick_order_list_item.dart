import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/orders/order_status.dart';
import 'package:widgets/quick_orders/quick_order_details.dart';

class QuickOrderListItem extends StatelessWidget {
  final QuickOrder quickOrder;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;
  final Function(QuickOrder)? deleteQuickOrder;
  final Function(QuickOrder)? updateQuickOrder;

  const QuickOrderListItem(
      {Key? key,
      required this.quickOrder,
      this.pickOrder,
      this.deliverOrder,
      this.deleteQuickOrder,
      this.updateQuickOrder})
      : super(key: key);

  void _showAlertDialog() {
    Get.dialog(AlertDialog(
      title: Text("change_quick_order".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                Get.back();
                updateQuickOrder?.call(quickOrder);
              },
              child: Text("update".tr)),
          const Divider(),
          TextButton(
              onPressed: () {
                Get.back();
                deleteQuickOrder?.call(quickOrder);
              },
              child: Text("delete".tr)),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.bottomSheet(QuickOrderDetails(
        quickOrder: quickOrder,
        pickOrder: pickOrder,
        deliverOrder: deliverOrder,
      )),
      onLongPress: () => _showAlertDialog(),
      leading: OrderStatusWidget(
        orderStatus: quickOrder.orderStatus,
      ),
      title: quickOrder.user?.name != null
          ? Text(
              quickOrder.user?.name ?? "",
              style: Get.textTheme.bodyText2,
            )
          : Text(
              quickOrder.phoneNumber ?? "",
              style: Get.textTheme.bodyText2,
            ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (quickOrder.address != null) Text(quickOrder.address ?? ""),
          Text(
            " ${quickOrder.formattedDate}  ${quickOrder.formattedTime} ",
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
      trailing: Column(
        children: [
          Text(quickOrder.inCity == true ? "in_menouf".tr : "out_menouf".tr),
          if (quickOrder.price != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${quickOrder.price.toString()} ${"le".tr}",
                style: TextStyle(color: Get.textTheme.bodyText1?.color),
              ),
            )
        ],
      ),
    );
  }
}
