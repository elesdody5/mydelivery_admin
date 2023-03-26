import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/cart_item.dart';
import 'package:core/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../record/quick_order_record_player.dart';
import 'details_list_tile.dart';

class OrderDetails extends StatelessWidget {
  final ShopOrder order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  Widget orderName(CartItem cartItem) {
    return cartItem.quantity != 0
        ? ListTile(
            title: Text(
                "${"quantity".tr} ${cartItem.quantity} ${cartItem.product?.name ?? ""}"),
            subtitle: Text(
              "${cartItem.price.toString()} ${"le".tr}",
              style: TextStyle(color: Get.textTheme.bodyText1?.color),
            ),
          )
        : Text(cartItem.product?.description ?? "");
  }

  void _showImagePreview() => Get.dialog(
        CachedNetworkImage(
          imageUrl: order.imageUrl ?? "",
          fit: BoxFit.contain,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          imageBuilder: (context, provider) => InteractiveViewer(
              panEnabled: false,
              // Set it to false to prevent panning.
              child: Container(
                decoration:
                    BoxDecoration(image: DecorationImage(image: provider)),
              )),
        ),
      );

  void _playRecord() =>
      Get.dialog(QuickOrderRecordPlayer(audioUrl: order.audioUrl ?? ""));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DetailsListTile(
              name: order.shop?.name,
              address: order.shop?.address,
              latitude: order.shop?.latitude,
              longitude: order.shop?.longitude,
              imageUrl: order.shop?.imageUrl,
              phone: order.shop?.phone,
              type: "shop".tr,
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "description".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                if (order.coins != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(order.coins?.toString() ?? ""),
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.amberAccent,
                            )
                          ],
                        ),
                        Text(
                          "${"after_apply_coins_message".tr} ${order.price - (order.coins ?? 0)} ${"le".tr}",
                        ),
                      ],
                    ),
                  )
              ],
            ),
            Column(
              children: order.cartItems
                      ?.map((cartItem) => orderName(cartItem))
                      .toList() ??
                  [],
            ),
            const Divider(
              thickness: 1,
            ),
            DetailsListTile(
              name: order.user?.name,
              imageUrl: order.user?.imageUrl,
              phone: order.user?.phone,
              latitude: order.user?.latitude,
              longitude: order.user?.longitude,
              address: order.user?.address,
              type: "user".tr,
            ),
            order.delivery == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "no_delivery".tr,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                : DetailsListTile(
                    name: order.delivery?.name,
                    imageUrl: order.delivery?.imageUrl,
                    phone: order.delivery?.phone,
                    type: "delivery".tr,
                  ),
            if (order.imageUrl != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _showImagePreview, child: Text("view_image".tr)),
              ),
            if (order.audioUrl != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: _playRecord, child: Text("play_record".tr)),
              ),
          ],
        ),
      ),
    );
  }
}
