
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/current_user_orders/current_orders/current_delivery_orders.dart';
import 'package:user_profile/current_user_orders/current_orders/current_delivery_provider.dart';

import 'all_current_user_orders_provider.dart';
import 'current_quick_orders/current_quick_orders_provider.dart';
import 'current_quick_orders/current_quick_orders_screen.dart';

class AllCurrentUserOrders extends StatelessWidget {
  const AllCurrentUserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllCurrentUserOrdersProvider>(context, listen: false);
    String userId = Get.arguments;
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
                Consumer<AllCurrentUserOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.currentQuickOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllCurrentUserOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"orders".tr} (${provider.currentOrdersCount})",
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
                value: CurrentQuickOrderProvider(
                    updateCurrentQuickOrderCount:
                        provider.setCurrentQuickOrdersCount),
                child: CurrentQuickOrdersScreen(
                  userId: userId,
                ),
              ),
              ChangeNotifierProvider.value(
                value: CurrentUserOrdersProvider(
                    updateCurrentOrderCount: provider.setCurrentOrdersCount),
                child: CurrentUserOrdersScreen(
                  userId: userId,
                ),
              ),
            ],
          ),
        ));
  }
}
