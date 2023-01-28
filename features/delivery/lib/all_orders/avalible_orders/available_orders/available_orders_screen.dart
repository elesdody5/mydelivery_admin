import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/orders_list_view.dart';
import 'package:widgets/search_widget.dart';

import '../widgets/available_orders_list.dart';
import 'available_orders_provider.dart';

class AllAvailableOrdersScreen extends StatelessWidget {
  const AllAvailableOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllAvailableOrdersProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    return FutureWithLoadingProgress(
        future: provider.getAvailableOrders,
        child: Consumer<AllAvailableOrdersProvider>(
            builder: (_, provider, child) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SearchWidget(
                        search: provider.searchOrder,
                        hint: "search_shop_name".tr,
                      ),
                    ),
                    Expanded(
                        child: provider.filteredOrders.isEmpty
                            ? Center(
                                child: EmptyWidget(
                                  title: "empty_orders".tr,
                                  icon: Image.asset(
                                      'assets/images/shopping-cart.png'),
                                ),
                              )
                            : OrdersListView(
                                orders: provider.filteredOrders,
                              )),
                  ],
                )));
  }
}
