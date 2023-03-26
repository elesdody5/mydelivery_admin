import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';
import 'package:flutter/material.dart';

import 'order_action_model.dart';
import 'order_list_item.dart';

class OrdersListView extends StatelessWidget {
  final List<ShopOrder> orders;

  final List<OrderActionModel>? orderActions;
  final Function(OrderStatus, String)? updateOrderStatus;

  const OrdersListView(
      {Key? key,
      required this.orders,
      this.orderActions,
      this.updateOrderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => OrderListItem(
              order: orders[index],
              orderActions: orderActions,
              updateOrderStatus: updateOrderStatus,
            ));
  }
}
