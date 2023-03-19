import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/avalible_orders/available_quick_orders/available_quick_orders_provider.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

class AvailableQuickOrders extends StatelessWidget {
  const AvailableQuickOrders({Key? key}) : super(key: key);

  void _setupListener(AvailableQuickOrderProvider provider) {
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
        Provider.of<AvailableQuickOrderProvider>(context, listen: false);
    _setupListener(provider);
    return FutureWithLoadingProgress(
      future: provider.getAvailableQuickOrders,
      child: Consumer<AvailableQuickOrderProvider>(
          builder: (_, provider, child) => provider.orders.isEmpty
              ? Center(
                  child: EmptyWidget(
                    title: "empty_orders".tr,
                    icon: Image.asset('assets/images/notification.png'),
                  ),
                )
              : QuickOrdersListView(
                  orders: provider.orders,
                  pickOrder: provider.pickOrder,
                )),
    );
  }
}
