import 'package:core/domain/address.dart';
import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickOrderAddress extends StatelessWidget {
  const QuickOrderAddress({
    Key? key,
    required this.quickOrder,
    required this.address,
  }) : super(key: key);

  final QuickOrder quickOrder;
  final Address? address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "address".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        address?.fullAddress != null
            ? Text(
                address!.fullAddress!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"from".tr} : ${quickOrder.address?.startDestination ?? ""}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "${"to".tr} : ${quickOrder.address?.endDestination ?? ""}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
