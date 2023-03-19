import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/vendor_quick_orders/vendor_quick_orders_provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';


class VendorQuickOrdersScreen extends StatelessWidget {
  const VendorQuickOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<VendorQuickOrdersProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("quick_order".tr),
      ),
      body: FutureWithLoadingProgress(
        future: provider.getCurrentDeliveryOrders,
        child: Consumer<VendorQuickOrdersProvider>(
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
      ),
    );
  }
}
