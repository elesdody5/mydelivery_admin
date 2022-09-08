import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widgets/user_avatar.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User delivery = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
        ),
      ),
    );
  }
}
