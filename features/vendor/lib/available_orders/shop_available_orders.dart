import 'package:core/model/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/available_orders/shop_avaliable_orders_provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/orders/order_action_model.dart';
import 'package:widgets/orders/orders_list_view.dart';

class ShopAvailableOrders extends StatelessWidget {
  const ShopAvailableOrders({Key? key}) : super(key: key);

  List<OrderActionModel> orderActions() {
    return [
      OrderActionModel(
          status: OrderStatus.inProgress, actionTitle: 'in_progress'.tr),
      OrderActionModel(
          status: OrderStatus.waitingDelivery, actionTitle: 'ready'.tr),
      OrderActionModel(
          status: OrderStatus.refusedFromShop,
          actionTitle: 'refused_from_shop'.tr),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ShopAvailableOrdersProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text('your_orders'.tr),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: FutureWithLoadingProgress(
          future: () => provider.getShopOrders(),
          child: Consumer<ShopAvailableOrdersProvider>(
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
                              orderActions: orderActions(),
                              updateOrderStatus: provider.updateOrderStatus,
                            )),
                    ],
                  )),
        ),
      ),
    );
  }
}
