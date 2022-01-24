import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/orders_list_view.dart';

import 'delivered_orders_provider.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  const DeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveredOrdersProvider>(context, listen: false);
    return FutureWithLoadingProgress(
      future: provider.getDeliveredOrders,
      child: Consumer<DeliveredOrdersProvider>(
          builder: (_, provider, child) => provider.orders.isEmpty
              ? EmptyWidget(
                  title: "empty_orders".tr,
                  icon: Image.asset('assets/images/delivery-man.png'),
                )
              : OrdersListView(
                  orders: provider.orders,
                )),
    );
  }
}
