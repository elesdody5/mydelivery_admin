import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListItem extends StatelessWidget {
  final CartItem cartItem;

  const ProductListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  void _showImagePreview() => Get.dialog(
        CachedNetworkImage(
          imageUrl: cartItem.product?.image ?? "",
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 80,
        height: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: _showImagePreview,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade300,
              ),
              placeholder: (_, __) => Container(
                color: Colors.grey.shade300,
              ),
              imageUrl: cartItem.product?.image ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(cartItem.product?.name ?? ""),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cartItem.product?.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                cartItem.product?.description ?? "",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              "${cartItem.product?.price.toString()} ${"le".tr}",
              style: TextStyle(
                  color: Get.theme.textTheme.bodyMedium?.color, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
