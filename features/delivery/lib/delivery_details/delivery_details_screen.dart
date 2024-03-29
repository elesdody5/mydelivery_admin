import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:delivery/delivery_details/delivery_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  void _setupListener(DeliveryDetailsProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupNavigationListener(provider.navigation);
  }


  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DeliveryDetailsProvider>(context, listen: false);
    User delivery = Get.arguments;
    _setupListener(provider);
    return Scaffold(
      body: SafeArea(
        child: FutureWithLoadingProgress(
          future: () => provider.init(delivery.id ?? ""),
          child: Consumer<DeliveryDetailsProvider>(
              builder: (context, provider, key) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserAvatar(
                    id: delivery.id ?? "",
                    imageUrl: delivery.imageUrl,
                    radius: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    delivery.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    'assets/images/profile.png',
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    "profile".tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () =>
                      Get.toNamed(deliveryProfileScreen, arguments: delivery),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.amber,
                  ),
                  title: Text(
                    "reviews".tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () => Get.toNamed(deliveryReviewsScreenRouteName,
                      arguments: delivery),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    size: 20,
                    color: Colors.amber,
                  ),
                  title: Text(
                    "coins".tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  trailing: Text("${provider.coins}"),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.visibility_off,
                    size: 20,
                    color: Colors.greenAccent,
                  ),
                  title: Text(
                    "hide_address".tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  trailing: Switch(
                    value: provider.isAddressHidden,
                    onChanged: (bool value) => provider
                        .updateAddressVisibilityState(delivery.id, value),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.block,
                    size: 20,
                    color: Colors.red,
                  ),
                  title: Text(
                    "block".tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  trailing: Switch(
                    value: provider.isBlocked,
                    onChanged: (bool value) =>
                        provider.updateBlockState(delivery.id, value),
                  ),
                ),
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text("orders".tr),
                  leading: Image.asset(
                    'assets/images/delivery-man.png',
                    width: 20,
                    height: 20,
                  ),
                  children: [
                    ListTile(
                        onTap: () => Get.toNamed(currentDeliveryOrdersScreen,
                            arguments: delivery.id),
                        title: Text("current_orders".tr)),
                    ListTile(
                        onTap: () => Get.toNamed(deliveryDeliveredOrdersScreen,
                            arguments: delivery.id),
                        title: Text("delivered_orders".tr)),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
