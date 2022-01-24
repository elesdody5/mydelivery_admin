import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

import '../widgets/available_orders_list.dart';
import 'available_orders_provider.dart';

class AvailableOrdersScreen extends StatelessWidget {
  const AvailableOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AvailableOrdersProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    return FutureWithLoadingProgress(
        future: provider.getAvailableOrders,
        child: Consumer<AvailableOrdersProvider>(
            builder: (_, provider, child) => provider.users.isEmpty
                ? Center(
                    child: EmptyWidget(
                      title: "empty_orders".tr,
                      icon: Image.asset('assets/images/shopping-cart.png'),
                    ),
                  )
                : AvailableOrdersList(
                    users: provider.users,
                    onTap: provider.navigateToUserOrderDetails,
                  )));
  }
}
