import 'package:core/domain/quick_order.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/deliverd_orders/delivered_orders/widgets/orders_list_tile.dart';
import 'package:widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import 'all_delivered_orders_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllDeliveredQuickOrdersScreen extends StatelessWidget {
  const AllDeliveredQuickOrdersScreen({Key? key}) : super(key: key);

  void _showAlertDialog(
      AllDeliveredQuickOrdersProvider provider, QuickOrder quickOrder) {
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

  Future<void> sendFeedback(QuickOrder quickOrder) async {
    if (quickOrder.endDestinationPhoneNumber != null &&
        quickOrder.endDestinationPhoneNumber!.isNotEmpty) {
      var phone = quickOrder.endDestinationPhoneNumber?.contains("+2") == true
          ? quickOrder.endDestinationPhoneNumber
          : "+2${quickOrder.endDestinationPhoneNumber}";

      var message = Uri.encodeComponent("feedback_message".tr);

      var whatsappUrl = "whatsapp://send?phone=$phone"
          "&text=$message";

      // bool foundWhatsapp = await canLaunch(whatsappUrl);
      launch(whatsappUrl);
    } else {
      showErrorDialog("please_enter_valid_phone".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureWithLoadingProgress(
      future:
          Provider.of<AllDeliveredQuickOrdersProvider>(context, listen: false)
              .getDeliveredQuickOrders,
      child: Consumer<AllDeliveredQuickOrdersProvider>(
          builder: (_, provider, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SearchWidget(
                      search: provider.searchQuickOrder,
                      hint: "search_address".tr,
                    ),
                  ),
                  OrdersListTile(
                      ordersNumber:
                          provider.filteredQuickOrders.length.toString(),
                      onDateSelected: provider.dateFilter),
                  Expanded(
                    child: provider.filteredQuickOrders.isEmpty
                        ? Center(
                            child: EmptyWidget(
                              title: "empty_orders".tr,
                              icon:
                                  Image.asset('assets/images/notification.png'),
                            ),
                          )
                        : QuickOrdersListView(
                            orders: provider.filteredQuickOrders,
                            deleteQuickOrder: (quickOrder) =>
                                _showAlertDialog(provider, quickOrder),
                            sendFeedbackMessage: sendFeedback,
                            updateQuickOrder: (quickOrder) async {
                              QuickOrder result = await Get.toNamed(
                                  quickOrderForm,
                                  arguments: quickOrder);
                              provider.updateQuickOrderInList(result);
                            },
                          ),
                  ),
                ],
              )),
    );
  }
}
