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
  final Function(QuickOrder)? sendQuickOrder;
  final Function(QuickOrder)? removeQuickOrderDebt;
  final Function(QuickOrder)? sendWhatsappMessage;
  final Function(QuickOrder)? sendFeedbackMessage;

  const QuickOrderListItem({
    Key? key,
    required this.quickOrder,
    this.pickOrder,
    this.deliverOrder,
    this.deleteQuickOrder,
    this.updateQuickOrder,
    this.sendQuickOrder,
    this.sendWhatsappMessage,
    this.sendFeedbackMessage,
    this.removeQuickOrderDebt,
  }) : super(key: key);

  void _showAlertDialog() {
    Get.dialog(AlertDialog(
      title: Text("change_quick_order".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sendWhatsappMessage != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  sendWhatsappMessage?.call(quickOrder);
                },
                child: Text("send_whats_app".tr)),
          const Divider(),
          if (updateQuickOrder != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  updateQuickOrder?.call(quickOrder);
                },
                child: Text("update".tr)),
          const Divider(),
          if (sendFeedbackMessage != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  sendFeedbackMessage!(quickOrder);
                },
                child: Text("feedback".tr)),
          if (sendQuickOrder != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  sendQuickOrder?.call(quickOrder);
                },
                child: Text("send_now".tr)),
          const Divider(),
          if (deleteQuickOrder != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  deleteQuickOrder?.call(quickOrder);
                },
                child: Text("delete".tr)),
          if (removeQuickOrderDebt != null)
            TextButton(
                onPressed: () {
                  Get.back();
                  removeQuickOrderDebt?.call(quickOrder);
                },
                child: Text("delete".tr)),
        ],
      ),
    ));
  }

  String _textAddress() {
    if (quickOrder.address?.startDestination != null) {
      return "${quickOrder.address?.startDestination ?? ""}  ${"to".tr}  ${quickOrder.address?.endDestination ?? ""}";
    } else {
      return quickOrder.address?.fullAddress ?? "";
    }
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
              style: Get.textTheme.bodySmall,
            )
          : Text(
              quickOrder.startDestinationPhoneNumber?.replaceAll(" ", "") ?? "",
              style: Get.textTheme.bodySmall,
            ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _textAddress(),
            style: Get.textTheme.bodySmall,
          ),
          Text(
            " ${quickOrder.formattedDate}  ${quickOrder.formattedTime} ",
            textDirection: TextDirection.ltr,
            style: Get.textTheme.bodySmall,
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
                style: TextStyle(color: Get.textTheme.bodyMedium?.color),
              ),
            )
        ],
      ),
    );
  }
}
