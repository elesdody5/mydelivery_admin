import 'package:core/base_provider.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';

import 'scheduled_quick_order_provider.dart';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:provider/provider.dart';

class ScheduledQuickOrderScreen extends StatelessWidget {
  const ScheduledQuickOrderScreen({Key? key}) : super(key: key);

  void _setupListener(ScheduledQuickOrdersProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    _setupSuccessMessageListener(provider.successMessage);
  }

  void _setupSuccessMessageListener(RxnString successMessage) {
    ever(successMessage, (String? message) {
      if (message != null) {
        _showSuccessDialog(message.tr);
        successMessage.clear();
      }
    });
  }

  void _showSuccessDialog(String message) {
    CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        text: "$message ${"please_contact_user".tr}",
        onConfirmBtnTap: () {
          Get.offNamedUntil(deliveryHomeScreen, (route) => false, arguments: 1);
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ScheduledQuickOrdersProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("scheduled_quick_order".tr),
      ),
      body: FutureWithLoadingProgress(
        future: provider.getScheduledQuickOrders,
        child: Consumer<ScheduledQuickOrdersProvider>(
            builder: (_, provider, child) => provider.quickOrders.isEmpty
                ? Center(
                    child: EmptyWidget(
                      title: "empty_orders".tr,
                      icon: Image.asset('assets/images/notification.png'),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuickOrdersListView(
                      orders: provider.quickOrders,
                      sendQuickOrder: provider.addQuickOrder,
                      deleteQuickOrder: provider.deleteQuickOrder,
                    ),
                  )),
      ),
    );
  }
}
