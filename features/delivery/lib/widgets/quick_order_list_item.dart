import 'package:core/domain/quick_order.dart';
import 'package:delivery/widgets/quick_order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/orders/order_status.dart';
import 'package:url_launcher/url_launcher.dart';

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
          ? Text(quickOrder.user?.name ?? "")
          : Text(
        quickOrder.phoneNumber ?? "",
      ),
      subtitle: Text(quickOrder.address ?? ""),
      trailing:
      Text(quickOrder.inCity == true ? "in_menouf".tr : "out_menouf".tr),
    );
  }
}
