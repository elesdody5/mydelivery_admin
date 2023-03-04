import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/orders/order_status.dart';
import 'package:widgets/quick_orders/quick_order_details.dart';

class QuickOrderListItem extends StatelessWidget {
  final QuickOrder quickOrder;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;

  const QuickOrderListItem(
      {Key? key, required this.quickOrder, this.pickOrder, this.deliverOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.bottomSheet(QuickOrderDetails(
        quickOrder: quickOrder,
        pickOrder: pickOrder,
        deliverOrder: deliverOrder,
      )),
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
      trailing:
          Text(quickOrder.inCity == true ? "in_menouf".tr : "out_menouf".tr),
    );
  }
}
