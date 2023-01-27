import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:widgets/search_widget.dart';
import 'package:flutter/material.dart';

import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/user_list/user_list_item/future_with_shimmer.dart';
import 'package:widgets/user_list/users_list_view.dart';
import 'delivery_list_provider.dart';

class DeliveryListScreen extends StatelessWidget {
  const DeliveryListScreen({Key? key}) : super(key: key);

  void _showAlertDialog(DeliveryListProvider provider, User delivery) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_delivery".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.removeDelivery(delivery);
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
    final provider = Provider.of<DeliveryListProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    setupLoadingListener(provider.isLoading);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed(signupScreenRouteName, arguments: UserType.delivery),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: UserListWithShimmer(
          future: provider.getAllDelivery,
          child: Consumer<DeliveryListProvider>(builder: (_, provider, __) {
            return provider.deliveryList.isEmpty
                ? EmptyWidget(
                    icon: Image.asset('assets/images/delivery-man.png'),
                    title: "empty_delivery_title".tr,
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: SearchWidget(search: provider.search),
                      ),
                      Expanded(
                        child: UsersListView(
                          usersList: provider.filteredDeliveryList,
                          onUserClicked: (delivery) => Get.toNamed(
                              deliveryDetailsScreenRouteName,
                              arguments: delivery),
                          onLongTap: (delivery) =>
                              _showAlertDialog(provider, delivery),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
