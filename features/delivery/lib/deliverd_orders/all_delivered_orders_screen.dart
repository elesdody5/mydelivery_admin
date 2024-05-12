import 'package:core/domain/user.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_orders/delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_orders/delivered_orders_screen.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeliveryDeliveredOrdersScreen extends StatelessWidget {
  const DeliveryDeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveryDeliveredOrdersProvider>(context, listen: false);
    User delivery = Get.arguments;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("delivered_orders".tr),
            bottom: TabBar(
              tabs: [
                Consumer<DeliveryDeliveredOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.deliveredQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<DeliveryDeliveredOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"orders".tr} (${provider.deliveredOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ChangeNotifierProvider.value(
                value: DeliveredQuickOrdersProvider(
                    updateDeliveredQuickOrderCount:
                        provider.setDeliveredQuickOrdersCount),
                child: DeliveredQuickOrdersScreen(
                  delivery: delivery,
                ),
              ),
              ChangeNotifierProvider.value(
                value: DeliveredOrdersProvider(
                    updateDeliveredOrderCount:
                        provider.setDeliveredOrdersCount),
                child: DeliveredOrdersScreen(
                  deliveryId: delivery.id ?? "",
                ),
              ),
            ],
          ),
        ));
  }
}
