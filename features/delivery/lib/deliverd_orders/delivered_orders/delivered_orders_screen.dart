import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/orders_list_view.dart';

import 'delivered_orders_provider.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  const DeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveredOrdersProvider>(context, listen: false);
    setupLoadingListener(provider.isLoading);
    return FutureWithLoadingProgress(
      future: provider.getDeliveredOrders,
      child: Consumer<DeliveredOrdersProvider>(
          builder: (_, provider, child) => provider.orders.isEmpty
              ? EmptyWidget(
                  title: "empty_orders".tr,
                  icon: Image.asset('assets/images/delivery-man.png'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: OrdersListView(
                          orders: provider.orders,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: null,
                        child: Text(
                            "${"total".tr} ${provider.totalDeliveryPrice} ${"le".tr}"),
                      ),
                      ElevatedButton(
                        onPressed: provider.removeOrders,
                        child: Text("delete".tr),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                      ),
                    ],
                  ),
                )),
    );
  }
}
