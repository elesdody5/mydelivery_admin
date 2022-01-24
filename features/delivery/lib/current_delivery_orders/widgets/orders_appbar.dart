import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersAppBar extends StatelessWidget {
  const OrdersAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
              title: Text(
                "your_orders".tr,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ))),
        ],
      ),
    );
  }
}
