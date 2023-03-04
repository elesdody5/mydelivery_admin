import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/deliverd_orders/delivered_orders/widgets/orders_list_tile.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/orders_list_view.dart';

import 'delivered_orders_provider.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  final String userId;

  const DeliveredOrdersScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveredOrdersProvider>(context, listen: false);
    setupLoadingListener(provider.isLoading);
    return FutureWithLoadingProgress(
      future: () => provider.getDeliveredOrders(userId),
      child: Consumer<DeliveredOrdersProvider>(
          builder: (_, provider, child) => provider.filteredOrders.isEmpty
              ? EmptyWidget(
                  title: "empty_orders".tr,
                  icon: Image.asset('assets/images/delivery-man.png'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OrdersListTile(
                          ordersNumber:
                              provider.filteredOrders.length.toString(),
                          onDateSelected: provider.dateFilter),
                      Expanded(
                        child: OrdersListView(
                          orders: provider.filteredOrders,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: null,
                        child: Text(
                            "${"total".tr} ${provider.totalDeliveryPrice} ${"le".tr}"),
                      ),
                      OutlinedButton(
                        onPressed: null,
                        child: Text(
                          "${"coin".tr} ${provider.totalCoins} ",
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
