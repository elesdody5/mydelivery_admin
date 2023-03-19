import 'package:widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import 'all_available_quick_orders_provider.dart';

class AllAvailableQuickOrdersScreen extends StatelessWidget {
  const AllAvailableQuickOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureWithLoadingProgress(
      future:
          Provider.of<AllAvailableQuickOrdersProvider>(context, listen: false)
              .getAvailableDeliveryOrders,
      child: Consumer<AllAvailableQuickOrdersProvider>(
          builder: (_, provider, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SearchWidget(
                      search: provider.searchQuickOrder,
                      hint: "search_address".tr,
                    ),
                  ),
                  Expanded(
                    child: provider.filteredQuickOrders.isEmpty
                        ? Center(
                            child: EmptyWidget(
                              title: "empty_orders".tr,
                              icon:
                                  Image.asset('assets/images/notification.png'),
                            ),
                          )
                        : QuickOrdersListView(
                            orders: provider.filteredQuickOrders,
                          ),
                  ),
                ],
              )),
    );
  }
}
