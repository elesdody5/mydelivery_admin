import 'package:core/utils/utils.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'package:delivery/widgets/quick_orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

import '../delivered_orders/widgets/orders_list_tile.dart';

class DeliveredQuickOrdersScreen extends StatelessWidget {
  const DeliveredQuickOrdersScreen({Key? key}) : super(key: key);

  void _setupListener(DeliveredQuickOrdersProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveredQuickOrdersProvider>(context, listen: false);
    _setupListener(provider);
    return FutureWithLoadingProgress(
      future: provider.getDeliveredDeliveryOrders,
      child: Consumer<DeliveredQuickOrdersProvider>(
          builder: (_, provider, child) => provider.filteredOrders.isEmpty
              ? Center(
                  child: EmptyWidget(
                    title: "empty_orders".tr,
                    icon: Image.asset('assets/images/notification.png'),
                  ),
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
                        child: QuickOrdersListView(
                          orders: provider.filteredOrders,
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: provider.removeOrders,
                      //   child: Text("delete".tr),
                      //   style: ButtonStyle(
                      //       backgroundColor:
                      //           MaterialStateProperty.all<Color>(Colors.red)),
                      // ),
                    ],
                  ),
                )),
    );
  }
}
