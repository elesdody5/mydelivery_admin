import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:widgets/orders/orders_list_view.dart';
import 'package:widgets/search_widget.dart';
import 'package:get/get_utils/get_utils.dart';

import 'all_with_delivery_provider.dart';

class WithDeliveryOrdersScreen extends StatelessWidget {
  const WithDeliveryOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureWithLoadingProgress(
      future: Provider.of<AllWithDeliveryOrdersProvider>(context, listen: false)
          .getWithDeliveryOrders,
      child: Consumer<AllWithDeliveryOrdersProvider>(
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
                              icon:
                                  Image.asset('assets/images/notification.png'),
                            ),
                          )
                        : OrdersListView(
                            orders: provider.filteredOrders,
                          ),
                  ),
                ],
              )),
    );
  }
}
