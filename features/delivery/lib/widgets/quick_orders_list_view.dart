import 'package:core/domain/quick_order.dart';
import 'package:delivery/widgets/quick_order_list_item.dart';
import 'package:flutter/material.dart';

class QuickOrdersListView extends StatelessWidget {
  final List<QuickOrder> orders;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;

  const QuickOrdersListView(
      {Key? key, required this.orders, this.pickOrder, this.deliverOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => QuickOrderListItem(
              quickOrder: orders[index],
              pickOrder: pickOrder,
              deliverOrder: deliverOrder,
            ));
  }
}
