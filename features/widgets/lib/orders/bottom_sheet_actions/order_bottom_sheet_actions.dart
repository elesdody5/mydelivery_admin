import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:widgets/orders/bottom_sheet_details/order_details.dart';

import '../order_action_model.dart';

class OrderBottomSheetActions extends StatelessWidget {
  final ShopOrder order;
  final List<OrderActionModel>? orderActions;
  final Function(OrderStatus, String)? updateOrderStatus;

  const OrderBottomSheetActions(
      {Key? key,
      required this.order,
      this.orderActions,
      this.updateOrderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('order_title'.tr),
      message: Text("change_order_status".tr),
      actions: [
        if (orderActions != null)
          ...orderActions!.map((action) => CupertinoActionSheetAction(
              child: Text(action.actionTitle),
              onPressed: () {
                updateOrderStatus?.call(action.status, order.id ?? "");
                Get.back();
              })),
        CupertinoActionSheetAction(
          child: Text("description".tr),
          onPressed: () => Get.bottomSheet(OrderDetails(order: order)),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("cancel".tr),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
