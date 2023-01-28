import 'package:delivery/all_orders/avalible_orders/available_orders/available_orders_provider.dart';
import 'package:delivery/all_orders/with_delivery/all_with_delivery_provider.dart';
import 'package:delivery/all_orders/with_delivery/with_delivery_orders_screen.dart';
import 'package:delivery/all_quick_orders/available_quick_orders/all_available_quick_orders_provider.dart';
import 'package:delivery/all_quick_orders/available_quick_orders/all_available_quick_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'AllOrdersProvider.dart';
import 'avalible_orders/available_orders/available_orders_screen.dart';
import 'deliverd_orders/all_delivered_orders_provider.dart';
import 'deliverd_orders/all_delivered_orders_screen.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllOrdersProvider>(context, listen: false);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "orders".tr,
              ),
              bottom: TabBar(
                tabs: [
                  Consumer<AllOrdersProvider>(
                      builder: (context, provider, child) {
                    return Tab(
                      child: Text(
                        "${"waitingDelivery".tr} (${provider.availableOrdersCount})",
                        style: Get.textTheme.bodyText2,
                      ),
                    );
                  }),
                  Consumer<AllOrdersProvider>(
                      builder: (context, provider, child) {
                    return Tab(
                      child: Text(
                        "${"withDelivery".tr} (${provider.withDeliveryOrdersCount})",
                        style: Get.textTheme.bodyText2,
                      ),
                    );
                  }),
                  Consumer<AllOrdersProvider>(
                      builder: (context, provider, child) {
                    return Tab(
                      child: Text(
                        "${"delivered".tr} (${provider.deliveredOrdersCount})",
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
                  value: AllAvailableOrdersProvider(
                      updateAvailableOrderCount:
                          provider.setAvailableOrdersCount),
                  child: const AllAvailableOrdersScreen(),
                ),
                ChangeNotifierProvider.value(
                  value: AllWithDeliveryOrdersProvider(
                      updateWithDeliveryOrderCount:
                          provider.setWithDeliveryOrdersCount),
                  child: const WithDeliveryOrdersScreen(),
                ),
                ChangeNotifierProvider.value(
                  value: AllDeliveredOrdersProvider(
                      updateDeliveredOrderCount:
                          provider.setDeliveredOrdersCount),
                  child: const AllDeliveredOrdersScreen(),
                ),
              ],
            )));
  }
}
