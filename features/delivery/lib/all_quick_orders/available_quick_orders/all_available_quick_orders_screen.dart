import 'package:core/domain/quick_order.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'package:widgets/quick_orders/quick_orders_list_view.dart';
import 'all_available_quick_orders_provider.dart';

class AllAvailableQuickOrdersScreen extends StatelessWidget {
  const AllAvailableQuickOrdersScreen({Key? key}) : super(key: key);

  void _setupListener(AllAvailableQuickOrdersProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
  }

  void _showAlertDialog(
      AllAvailableQuickOrdersProvider provider, QuickOrder quickOrder) {
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

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllAvailableQuickOrdersProvider>(context, listen: false);
    _setupListener(provider);
    return FutureWithLoadingProgress(
      future: provider.getAvailableDeliveryOrders,
      child: Consumer<AllAvailableQuickOrdersProvider>(
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
