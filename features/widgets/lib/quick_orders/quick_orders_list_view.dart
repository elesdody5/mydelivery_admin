import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:widgets/quick_orders/quick_order_list_item.dart';

class QuickOrdersListView extends StatelessWidget {
  final List<QuickOrder> orders;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;

  const QuickOrdersListView(
      {Key? key, required this.orders, this.pickOrder, this.deliverOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      itemBuilder: (context, index) => QuickOrderListItem(
        quickOrder: orders[index],
        pickOrder: pickOrder,
        deliverOrder: deliverOrder,
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
    );
  }
}
