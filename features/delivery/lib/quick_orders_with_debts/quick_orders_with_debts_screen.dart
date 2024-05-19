import 'package:core/domain/quick_order.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/quick_orders_with_debts/quick_orders_with_debts_provider.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';

class QuickOrdersWithDebtsScreen extends StatelessWidget {
  const QuickOrdersWithDebtsScreen({Key? key}) : super(key: key);

  void _showAlertDialog(
      QuickOrdersWithDebtsProvider provider, QuickOrder quickOrder) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_from_debts".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.updateQuickOrderDebt(quickOrder);
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
    String deliveryId = Get.arguments;
    final provider =
        Provider.of<QuickOrdersWithDebtsProvider>(context, listen: false);
    setupErrorMessageListener(provider.errorMessage);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "custody".tr,
          )),
      body: FutureWithLoadingProgress(
        future: () => provider.getDeliveryQuickOrdersWithDebts(deliveryId),
        child: Consumer<QuickOrdersWithDebtsProvider>(
          builder: (_, provider, child) => provider.quickOrders.isEmpty
              ? Center(
                  child: EmptyWidget(
                    title: "empty_orders".tr,
                    icon: const Icon(
                      Icons.receipt_long,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${provider.totalDebts.toString()} ${"le".tr}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: QuickOrdersListView(
                      orders: provider.quickOrders,
                      removeQuickOrderDebt: (quickOrder) =>
                          _showAlertDialog(provider, quickOrder),
                    )),
                  ],
                ),
        ),
      ),
    );
  }
}
