import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:vendor/vendors_list_screen/vendors_list_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/user_list/user_list_item/future_with_shimmer.dart';
import 'package:widgets/user_list/users_list_view.dart';

class VendorsListScreen extends StatelessWidget {
  const VendorsListScreen({Key? key}) : super(key: key);

  void _showAlertDialog(VendorsListProvider provider, User vendor) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_delivery".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.removeVendor(vendor);
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
    final provider = Provider.of<VendorsListProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    setupLoadingListener(provider.isLoading);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed(signupScreenRouteName, arguments: UserType.vendor),
        child: const Icon(Icons.add),
      ),
      body: UserListWithShimmer(
        future: provider.getAllVendors,
        child: Consumer<VendorsListProvider>(builder: (_, provider, __) {
          return provider.vendorsList.isEmpty
              ? EmptyWidget(
                  icon: const Icon(Icons.account_circle_rounded),
                  title: "empty_vendor_title".tr,
                )
              : UsersListView(
                  usersList: provider.vendorsList,
                  onUserClicked: provider.onDeliveryClicked,
                  onLongTap: (delivery) => _showAlertDialog(provider, delivery),
                );
        }),
      ),
    );
  }
}
