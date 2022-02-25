import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/shop.dart';
import 'package:core/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopListItem extends StatelessWidget {
  final Shop shop;

  const ShopListItem({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(shopDetailsScreenRouteName, arguments: shop.id),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Get.theme.cardColor,
              title: Text(
                shop.name ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                overflow: TextOverflow.visible,
              ),
              subtitle: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        color: Get.theme.primaryColor),
                    child: const Center(
                      child: Icon(
                        Icons.access_time_rounded,
                        color: Colors.black,
                        size: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      shop.openTime ?? "",
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            child: Hero(
              tag: shop.id ?? 0,
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (_, __) => Container(
                  color: Colors.grey.shade300,
                ),
                imageUrl: shop.imageUrl ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
