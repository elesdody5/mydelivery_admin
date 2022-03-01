import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/orders/bottom_sheet_actions/order_bottom_sheet_actions.dart';
import 'package:widgets/orders/order_action_model.dart';

import 'bottom_sheet_details/order_details.dart';
import 'order_status.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  final List<OrderActionModel>? orderActions;
  final Function(OrderStatus, String)? updateOrderStatus;

  const OrderListItem(
      {Key? key,
      required this.order,
      this.orderActions,
      this.updateOrderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.bottomSheet(OrderDetails(order: order)),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Get.theme.cardColor, borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: ListTile(
                  leading: OrderStatusWidget(
                    orderStatus: order.status,
                  ),
                  title: Text(
                    "${order.cartItems?.first.product?.name ?? ""}...",
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.shop?.name ?? ""),
                      Text(
                        " ${order.formattedDate}  ${order.formattedTime} ",
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                  trailing: Text(
                    "${order.price.toString()} ${"le".tr} \n   +   \n ${order.deliveryPrice} ${"le".tr}",
                    style: TextStyle(color: Get.textTheme.bodyText1?.color),
                  ),
                ),
              ),
              if (order.delivery != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${"delivery".tr} ${order.delivery?.name ?? ""} "),
                      Icon(
                        Icons.phone,
                        color: Get.theme.primaryIconTheme.color,
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
