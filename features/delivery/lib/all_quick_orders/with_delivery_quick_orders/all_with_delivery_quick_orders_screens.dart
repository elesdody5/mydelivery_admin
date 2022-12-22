import 'package:delivery/all_quick_orders/with_delivery_quick_orders/all_with_delivery_quick_orders_provider.dart';
import 'package:delivery/delivery_list/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../widgets/quick_orders_list_view.dart';

class AllWithDeliveryQuickOrdersScreen extends StatelessWidget {
  const AllWithDeliveryQuickOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AllWithDeliveryQuickOrdersProvider>(
        builder: (_, provider, child) => Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            icon: Image.asset('assets/images/notification.png'),
                          ),
                        )
                      : QuickOrdersListView(
                          orders: provider.filteredQuickOrders,
                        ),
                ),
              ],
            ));
  }
}
