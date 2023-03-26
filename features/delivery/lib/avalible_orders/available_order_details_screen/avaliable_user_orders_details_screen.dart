import 'package:cool_alert/cool_alert.dart';
import 'package:core/base_provider.dart';
import 'package:core/model/order.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/orders/orders_list_view.dart';

import 'avaliable_user_order_provider.dart';

class AvailableUserOrdersDetailsScreen extends StatelessWidget {
  AvailableUserOrdersDetailsScreen({Key? key}) : super(key: key);
  late AvailableUserOrdersDetailsProvider provider;

  void _setupListener() {
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
        text: message,
        onConfirmBtnTap: () {
          Get.offNamedUntil(deliveryHomeScreen, (route) => false, arguments: 1);
        });
  }

  @override
  Widget build(BuildContext context) {
    List<ShopOrder>? orders = Get.arguments;

    provider =
        Provider.of<AvailableUserOrdersDetailsProvider>(context, listen: false);
    provider.orders = orders ?? [];
    _setupListener();
    return Scaffold(
        appBar: AppBar(),
        body: OrdersListView(
          orders: provider.orders,
        ));
  }
}
