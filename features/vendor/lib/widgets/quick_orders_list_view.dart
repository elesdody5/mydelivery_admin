import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:vendor/widgets/quick_order_list_item.dart';

class QuickOrdersListView extends StatelessWidget {
  final List<QuickOrder> orders;

  const QuickOrdersListView({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      itemBuilder: (context, index) => QuickOrderListItem(
        quickOrder: orders[index],
      ),
      separatorBuilder: (BuildContext context, int index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Divider(
          thickness: 1,
        ),
      ),
    );
  }
}
