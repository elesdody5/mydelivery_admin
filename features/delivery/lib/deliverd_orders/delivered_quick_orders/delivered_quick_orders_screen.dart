import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/deliverd_orders/delivered_quick_orders/delivered_quick_orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import '../delivered_orders/widgets/orders_list_tile.dart';
import 'package:cool_alert/cool_alert.dart';

class DeliveredQuickOrdersScreen extends StatelessWidget {
  final User delivery;

  const DeliveredQuickOrdersScreen({Key? key, required this.delivery})
      : super(key: key);

  void _setupListener(DeliveredQuickOrdersProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    _setupSuccessMessageListener(provider);
  }

  void _setupSuccessMessageListener(DeliveredQuickOrdersProvider provider) {
    ever(provider.successMessage, (String? message) {
      if (message != null) {
        _showSuccessDialog(provider);
        provider.successMessage.clear();
      }
    });
  }

  void _showSuccessDialog(DeliveredQuickOrdersProvider provider) {
    CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        text: provider.successMessage.value?.tr,
        onConfirmBtnTap: () {
          Get.back();
          Get.back(result: provider.delivery);
        });
  }

  void _showAlertDialog(
      DeliveredQuickOrdersProvider provider, QuickOrder quickOrder) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_order".tr),
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

  void _updateQuickOrdersConfirmation(DeliveredQuickOrdersProvider provider) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_order".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.settleQuickOrders(delivery.id ?? "");
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
        Provider.of<DeliveredQuickOrdersProvider>(context, listen: false);

    _setupListener(provider);
    return FutureWithLoadingProgress(
      future: () => provider.init(delivery),
      child: Consumer<DeliveredQuickOrdersProvider>(
          builder: (_, provider, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OrdersListTile(
                        ordersNumber: provider.filteredOrders.length.toString(),
                        onDateSelected: provider.dateFilter),
                    RadioListTile(
                      value: true,
                      groupValue: provider.inCityFilter,
                      onChanged: (value) => provider.filterWithCity(true),
                      title: Text("in_menouf".tr),
                    ),
                    RadioListTile(
                      value: false,
                      groupValue: provider.inCityFilter,
                      onChanged: (value) => provider.filterWithCity(false),
                      title: Text("out_menouf".tr),
                    ),
                    provider.filteredOrders.isEmpty
                        ? Center(
                            child: EmptyWidget(
                              title: "empty_orders".tr,
                              icon:
                                  Image.asset('assets/images/notification.png'),
                            ),
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: QuickOrdersListView(
                                    orders: provider.filteredOrders,
                                    deleteQuickOrder: (quickOrder) =>
                                        _showAlertDialog(provider, quickOrder),
                                    updateQuickOrder: (quickOrder) async {
                                      QuickOrder result = await Get.toNamed(
                                          quickOrderForm,
                                          arguments: quickOrder);
                                      provider.updateQuickOrderInList(result);
                                    },
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(
                                    "${"total_orders".tr} ${provider.ordersCount} ",
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(
                                    "${"total_delivery_price".tr} ${provider.totalPrice ?? "0"} ",
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(
                                    "${"office_percent".tr} ${provider.profitPercent ?? "0"}",
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      _updateQuickOrdersConfirmation(provider),
                                  child: Text("delete_history".tr),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )),
    );
  }
}
