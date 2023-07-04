import 'package:core/domain/quick_order.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/current_delivery_orders/current_quick_orders/current_quick_orders_provider.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

class CurrentQuickOrdersScreen extends StatelessWidget {
  final String deliveryId;

  const CurrentQuickOrdersScreen({Key? key, required this.deliveryId})
      : super(key: key);

  void _setupListener(CurrentQuickOrderProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  void _showAlertDialog(
      CurrentQuickOrderProvider provider, QuickOrder quickOrder) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_shop".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.deleteQuickOrder(quickOrder);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CurrentQuickOrderProvider>(context, listen: false);
    _setupListener(provider);

    return FutureWithLoadingProgress(
      future: () => provider.getCurrentDeliveryOrders(deliveryId),
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
                  deliverOrder: provider.changeQuickOrderStatus,
                  deleteQuickOrder: (quickOrder) =>
                      _showAlertDialog(provider, quickOrder),
                  updateQuickOrder: (quickOrder) async {
                    QuickOrder result = await Get.toNamed(quickOrderForm,
                        arguments: quickOrder);
                    provider.updateQuickOrderInList(result);
                  },
                )),
    );
  }
}
