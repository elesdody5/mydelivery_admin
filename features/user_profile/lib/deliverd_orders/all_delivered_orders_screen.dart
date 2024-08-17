import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/deliverd_orders/all_delivered_orders_provider.dart';

import 'delivered_orders/delivered_orders_provider.dart';
import 'delivered_orders/delivered_orders_screen.dart';
import 'delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'delivered_quick_orders/delivered_quick_orders_screen.dart';

class UserDeliveredOrdersScreen extends StatelessWidget {
  const UserDeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<UserDeliveredOrdersProvider>(context, listen: false);
    String userId = Get.arguments;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("delivered_orders".tr),
            bottom: TabBar(
              tabs: [
                Consumer<UserDeliveredOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.deliveredQuickOrdersCount})",
                      style: Get.textTheme.bodySmall,
                    ),
                  );
                }),
                Consumer<UserDeliveredOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"orders".tr} (${provider.deliveredOrdersCount})",
                      style: Get.textTheme.bodySmall,
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
                child: UserQuickOrdersScreen(
                  userId: userId,
                ),
              ),
              ChangeNotifierProvider.value(
                value: DeliveredOrdersProvider(
                    updateDeliveredOrderCount:
                        provider.setDeliveredOrdersCount),
                child: DeliveredOrdersScreen(
                  userId: userId,
                ),
              ),
            ],
          ),
        ));
  }
}
