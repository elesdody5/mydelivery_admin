import 'package:delivery/all_quick_orders/all_quick_orders_provider.dart';
import 'package:delivery/all_quick_orders/available_quick_orders/all_available_quick_orders_provider.dart';
import 'package:delivery/all_quick_orders/available_quick_orders/all_available_quick_orders_screen.dart';
import 'package:delivery/all_quick_orders/dilivered_orders/all_delivered_orders_provider.dart';
import 'package:delivery/all_quick_orders/dilivered_orders/all_delivered_orders_screen.dart';
import 'package:delivery/all_quick_orders/with_delivery_quick_orders/all_with_delivery_quick_orders_provider.dart';
import 'package:delivery/all_quick_orders/with_delivery_quick_orders/all_with_delivery_quick_orders_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/future_with_loading_progress.dart';

class AllQuickOrdersScreen extends StatelessWidget {
  const AllQuickOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allQuickOrdersProvider =
        Provider.of<AllQuickOrdersProvider>(context, listen: false);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "quick_order".tr,
            ),
            bottom: TabBar(
              tabs: [
                Consumer<AllQuickOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"waitingDelivery".tr} (${provider.availableQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllQuickOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"withDelivery".tr} (${provider.withDeliveryQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllQuickOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"delivered".tr} (${provider.deliveredQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
              ],
            ),
          ),
          body: FutureWithLoadingProgress(
            future: allQuickOrdersProvider.getAllQuickOrders,
            child: Consumer<AllQuickOrdersProvider>(
                builder: (context, provider, child) {
              return TabBarView(
                children: [
                  ChangeNotifierProvider.value(
                    value: AllAvailableQuickOrdersProvider(
                        provider.availableQuickOrders),
                    child: const AllAvailableQuickOrdersScreen(),
                  ),
                  ChangeNotifierProvider.value(
                    value: AllWithDeliveryQuickOrdersProvider(
                        provider.withDeliveryQuickOrders),
                    child: const AllWithDeliveryQuickOrdersScreen(),
                  ),
                  ChangeNotifierProvider.value(
                    value: AllDeliveredQuickOrdersProvider(
                        provider.deliveredQuickOrders),
                    child: const AllDeliveredQuickOrdersScreen(),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
