import 'package:delivery/current_delivery_orders/all_current_delivery_orders_provider.dart';
import 'package:delivery/current_delivery_orders/current_orders/current_delivery_orders.dart';
import 'package:delivery/current_delivery_orders/current_orders/current_delivery_provider.dart';
import 'package:delivery/current_delivery_orders/current_quick_orders/current_quick_orders_provider.dart';
import 'package:delivery/current_delivery_orders/current_quick_orders/current_quick_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllCurrentDeliveryOrders extends StatelessWidget {
  const AllCurrentDeliveryOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllCurrentOrdersProvider>(context, listen: false);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "your_orders".tr,
            ),
            bottom: TabBar(
              tabs: [
                Consumer<AllCurrentOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"orders".tr} (${provider.currentOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllCurrentOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.currentQuickOrdersCount})",
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
                value: CurrentDeliveryOrdersProvider(
                    updateCurrentOrderCount: provider.setCurrentOrdersCount),
                child: const CurrentDeliveryOrdersScreen(),
              ),
              ChangeNotifierProvider.value(
                value: CurrentQuickOrderProvider(
                    updateCurrentQuickOrderCount:
                        provider.setCurrentQuickOrdersCount),
                child: const CurrentQuickOrdersScreen(),
              ),
            ],
          ),
        ));
  }
}
