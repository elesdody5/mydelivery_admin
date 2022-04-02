import 'package:delivery/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_orders/delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_orders/delivered_orders_screen.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllDeliveredOrdersScreen extends StatelessWidget {
  const AllDeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllDeliveredOrdersProvider>(context, listen: false);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("delivered_orders".tr),
            bottom: TabBar(
              tabs: [
                Consumer<AllDeliveredOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.deliveredQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllDeliveredOrdersProvider>(
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
                child: const DeliveredQuickOrdersScreen(),
              ),
              ChangeNotifierProvider.value(
                value: DeliveredOrdersProvider(
                    updateDeliveredOrderCount:
                        provider.setDeliveredOrdersCount),
                child: const DeliveredOrdersScreen(),
              ),
            ],
          ),
        ));
  }
}
