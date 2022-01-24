import 'package:core/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'details_list_tile.dart';

class OrderDetails extends StatelessWidget {
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "description".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Wrap(
            children: order.cartItems
                    ?.map((cartItem) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cartItem.product?.name ?? ""),
                        ))
                    .toList() ??
                [],
          ),
          DetailsListTile(
            name: order.shop?.name,
            address: order.shop?.address,
            latitude: order.shop?.latitude,
            longitude: order.shop?.longitude,
            imageUrl: order.shop?.imageUrl,
            phone: order.shop?.phone,
          ),
          const Divider(
            thickness: 1,
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
          ),
        ],
      ),
    );
  }
}
