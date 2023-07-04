import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:widgets/quick_orders/quick_order_list_item.dart';

class QuickOrdersListView extends StatelessWidget {
  final List<QuickOrder> orders;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;
  final Function(QuickOrder)? deleteQuickOrder;
  final Function(QuickOrder)? updateQuickOrder;

  const QuickOrdersListView(
      {Key? key,
      required this.orders,
      this.pickOrder,
      this.deliverOrder,
      this.deleteQuickOrder,
      this.updateQuickOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      itemBuilder: (context, index) => QuickOrderListItem(
        quickOrder: orders[index],
        pickOrder: pickOrder,
        deliverOrder: deliverOrder,
        deleteQuickOrder: deleteQuickOrder,
        updateQuickOrder: updateQuickOrder,
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
    );
  }
}
