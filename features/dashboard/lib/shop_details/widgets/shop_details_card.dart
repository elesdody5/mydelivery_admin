import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/shop.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:core/utils/utils.dart';
import 'shop_info.dart';

class ShopDetailsCard extends StatelessWidget {
  final Shop? shop;
  final Function() openLocation;
  final Function() openWhatsapp;

  const ShopDetailsCard({
    Key? key,
    required this.shop,
    required this.openLocation,
    required this.openWhatsapp,
  }) : super(key: key);

  String? workingTime() {
    return shop?.startHour != null
        ? "${shop?.startHour?.timeFormat()} - ${shop?.endHour?.timeFormat()}"
        : shop?.openTime;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: ShopInfo(
                      onTap: openLocation,
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      title: "address".tr,
                      subtitle: shop?.address ?? "",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ShopInfo(
                      onTap: () {},
                      icon: const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.black,
                      ),
                      title: "time".tr,
                      subtitle: workingTime() ?? "",
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ShopInfo(
                          onTap: openWhatsapp,
                          icon: Image.asset(
                            "assets/images/whatsapp.png",
                            width: 20,
                            height: 20,
                          ),
                          title: "whatsapp".tr,
                          subtitle: ""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.only(right: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: shop?.id ?? "",
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                      ),
                      placeholder: (_, __) => Container(
                        color: Colors.grey.shade300,
                      ),
                      imageUrl: shop?.imageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8),
                  child: Text(
                    shop?.name ?? "",
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
