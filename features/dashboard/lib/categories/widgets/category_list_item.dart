import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/category.dart';
import 'package:core/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  const CategoryListItem(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.toNamed(shopsScreenRouteName, arguments: category),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Get.theme.primaryColor),
              child: CachedNetworkImage(
                imageUrl: category.imageUrl ?? "",
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(category.name ?? ""),
        )
      ],
    );
  }
}
