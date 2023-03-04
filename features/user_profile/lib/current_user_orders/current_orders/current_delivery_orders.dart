import 'package:core/model/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/order_action_model.dart';
import 'package:widgets/orders/orders_list_view.dart';

import 'current_delivery_provider.dart';

class CurrentUserOrdersScreen extends StatelessWidget {
  final String userId;

  const CurrentUserOrdersScreen({Key? key, required this.userId})
      : super(key: key);

  List<OrderActionModel> orderActions() {
    return [
      OrderActionModel(
          status: OrderStatus.withDelivery, actionTitle: 'pick_from_shop'.tr),
      OrderActionModel(
          status: OrderStatus.delivered, actionTitle: 'delivered'.tr)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CurrentUserOrdersProvider>(context, listen: false);
    String userId = Get.arguments;
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        child: FutureWithLoadingProgress(
          future: () => provider.getUserOrders(userId),
          child: Consumer<CurrentUserOrdersProvider>(
              builder: (_, provider, child) => provider.orders.isEmpty
                  ? EmptyWidget(
                      title: "empty_orders".tr,
                      icon: Image.asset('assets/images/delivery-man.png'),
                    )
                  : OrdersListView(
                      orders: provider.orders,
                    )),
        ),
      ),
    );
  }
}
