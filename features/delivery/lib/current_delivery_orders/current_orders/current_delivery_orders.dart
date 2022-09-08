import 'package:core/model/order_status.dart';
import 'package:delivery/current_delivery_orders/current_orders/current_delivery_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/order_action_model.dart';
import 'package:widgets/orders/orders_list_view.dart';

class CurrentDeliveryOrdersScreen extends StatelessWidget {
  final String deliveryId;

  const CurrentDeliveryOrdersScreen({Key? key, required this.deliveryId})
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
        Provider.of<CurrentDeliveryOrdersProvider>(context, listen: false);
    String deliveryId = Get.arguments;
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        child: FutureWithLoadingProgress(
          future: () => provider.getDeliveryOrders(deliveryId),
          child: Consumer<CurrentDeliveryOrdersProvider>(
              builder: (_, provider, child) => provider.orders.isEmpty
                  ? EmptyWidget(
                      title: "empty_orders".tr,
                      icon: Image.asset('assets/images/delivery-man.png'),
                    )
                  : OrdersListView(
                      orders: provider.orders,
                      orderActions: orderActions(),
                      updateOrderStatus: provider.updateOrderStatus,
                    )),
        ),
      ),
    );
  }
}
