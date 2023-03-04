import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';

import 'current_quick_orders_provider.dart';

class CurrentQuickOrdersScreen extends StatelessWidget {
  final String userId ;
  const CurrentQuickOrdersScreen({Key? key,required this.userId}) : super(key: key);

  void _setupListener(CurrentQuickOrderProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CurrentQuickOrderProvider>(context, listen: false);
    _setupListener(provider);

    return FutureWithLoadingProgress(
      future: () => provider.getCurrentDeliveryOrders(userId),
      child: Consumer<CurrentQuickOrderProvider>(
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
