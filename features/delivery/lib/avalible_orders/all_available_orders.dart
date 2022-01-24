import 'package:delivery/avalible_orders/all_available_orders_provider.dart';
import 'package:delivery/avalible_orders/available_quick_orders/available_quick_orders.dart';
import 'package:delivery/avalible_orders/available_quick_orders/available_quick_orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'available_orders/available_orders_provider.dart';
import 'available_orders/available_orders_screen.dart';

class AllAvailableOrdersScreen extends StatelessWidget {
  const AllAvailableOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllAvailableOrdersProvider>(context, listen: false);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "available_orders".tr,
            ),
            bottom: TabBar(
              tabs: [
                Consumer<AllAvailableOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"orders".tr} (${provider.availableOrdersCount})",
                      style: Get.textTheme.bodyText2,
                    ),
                  );
                }),
                Consumer<AllAvailableOrdersProvider>(
                    builder: (context, provider, child) {
                  return Tab(
                    child: Text(
                      "${"quick_order".tr} (${provider.availableQuickOrdersCount})",
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
                value: AvailableOrdersProvider(
                    updateAvailableOrderCount:
                        provider.setAvailableOrdersCount),
                child: const AvailableOrdersScreen(),
              ),
              ChangeNotifierProvider.value(
                value: AvailableQuickOrderProvider(),
                child: const AvailableQuickOrders(),
              ),
            ],
          ),
        ));
  }
}
