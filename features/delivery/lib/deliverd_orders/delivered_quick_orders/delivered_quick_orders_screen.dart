import 'package:core/utils/utils.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'package:delivery/widgets/quick_orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

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
          builder: (_, provider, child) => provider.orders.isEmpty
              ? Center(
                  child: EmptyWidget(
                    title: "empty_orders".tr,
                    icon: Image.asset('assets/images/notification.png'),
                  ),
                )
              : QuickOrdersListView(
                  orders: provider.orders,
                )),
    );
  }
}
