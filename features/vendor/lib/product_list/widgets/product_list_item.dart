import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final Function(Product) removeProduct;
  final Function(Product) onProductTap;

  const ProductListItem(
      {Key? key,
      required this.product,
      required this.removeProduct,
      required this.onProductTap})
      : super(key: key);

  void _showImagePreview() => Get.dialog(
        CachedNetworkImage(
          imageUrl: product.image ?? "",
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
      onTap: () => onProductTap(product),
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
              imageUrl: product.image ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(product.name ?? ""),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                product.description ?? "",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              "${product.price.toString()} ${"le".tr}",
              style: TextStyle(
                  color: Get.theme.textTheme.bodyText1?.color, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
