import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/delivered_orders/shop_delivered_orders_provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/orders_list_view.dart';

class ShopDeliveredOrdersScreen extends StatelessWidget {
  const ShopDeliveredOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ShopDeliveredOrdersProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text('delivered_orders'.tr),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: FutureWithLoadingProgress(
          future: () => provider.getShopDeliveredOrders(),
          child: Consumer<ShopDeliveredOrdersProvider>(
              builder: (_, provider, child) => Column(
                    children: [
                      provider.orders.isEmpty
                          ? EmptyWidget(
                              title: "empty_orders".tr,
                              icon:
                                  Image.asset('assets/images/delivery-man.png'),
                            )
                          : Expanded(
                              child: OrdersListView(
                              orders: provider.orders,
                            )),
                    ],
                  )),
        ),
      ),
    );
  }
}
