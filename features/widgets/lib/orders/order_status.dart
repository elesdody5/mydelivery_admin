import 'package:core/model/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatus? orderStatus;

  const OrderStatusWidget({Key? key, required this.orderStatus})
      : super(key: key);

  Color? _getOrderColor() {
    switch (orderStatus) {
      case OrderStatus.waitingShopResponse:
        return Get.theme.cardColor;
      case OrderStatus.waitingDelivery:
        return Get.theme.cardColor;
      case OrderStatus.refusedFromShop:
        return Get.theme.primaryColor;
      case OrderStatus.inProgress:
        return Get.theme.primaryColor;
      case OrderStatus.withDelivery:
        return Get.theme.primaryColor;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.done:
        return Colors.green;
      default:
        return Get.theme.cardColor;
    }
  }

  Icon? _getOrderIcon() {
    switch (orderStatus) {
      case OrderStatus.waitingShopResponse:
        return const Icon(Icons.access_time_rounded);
      case OrderStatus.waitingDelivery:
        return const Icon(Icons.access_time_rounded);
      case OrderStatus.refusedFromShop:
        return Icon(Icons.close, color: Get.theme.primaryIconTheme.color);
      case OrderStatus.inProgress:
        return Icon(Icons.access_time_rounded,
            color: Get.theme.primaryIconTheme.color);
      case OrderStatus.withDelivery:
        return Icon(Icons.pedal_bike_rounded,
            color: Get.theme.primaryIconTheme.color);
      case OrderStatus.delivered:
        return const Icon(Icons.check, color: Colors.white);
      case OrderStatus.done:
        return const Icon(Icons.check, color: Colors.white);
      default:
        return const Icon(Icons.access_time_rounded);
    }
  }

  Text? _getOrderTitle() {
    switch (orderStatus) {
      case OrderStatus.waitingShopResponse:
        return Text(
          "waiting".tr,
          style: const TextStyle(color: Colors.grey),
        );
      case OrderStatus.waitingDelivery:
        return Text(
          "waitingDelivery".tr,
          style: const TextStyle(color: Colors.grey),
        );
      case OrderStatus.refusedFromShop:
        return Text(
          "refusedFromShop".tr,
          style: const TextStyle(
            color: Colors.grey,
          ),
          softWrap: true,
        );
      case OrderStatus.inProgress:
        return Text(
          "inProgress".tr,
          style: TextStyle(color: Get.textTheme.bodyMedium?.color),
        );
      case OrderStatus.withDelivery:
        return Text(
          "on_my_way".tr,
          style: TextStyle(color: Get.textTheme.bodyMedium?.color),
        );
      case OrderStatus.delivered:
        return Text(
          "delivered".tr,
          style: const TextStyle(color: Colors.white),
        );
      case OrderStatus.done:
        return Text(
          "delivered".tr,
          style: const TextStyle(color: Colors.white),
        );
      default:
        return Text(
          "waiting".tr,
          style: const TextStyle(color: Colors.grey),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _getOrderColor(),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _getOrderIcon() ?? Container(),
            FittedBox(
                fit: BoxFit.contain, child: _getOrderTitle() ?? Container())
          ],
        ),
      ),
    );
  }
}
