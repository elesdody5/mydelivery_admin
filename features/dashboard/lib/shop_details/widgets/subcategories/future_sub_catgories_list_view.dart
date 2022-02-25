import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets/error_widget.dart';

import '../../shop_details_provider.dart';
import 'shimmer_subcategory_list.dart';
import 'subcategory_list_view.dart';

class FutureSubCategoriesListView extends StatelessWidget {
  final String? shopId;

  const FutureSubCategoriesListView({Key? key, required this.shopId})
      : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder(
        future: Provider.of<ShopDetailsProvider>(context, listen: false)
            .getShopSubCategories(shopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    const ShimmerSubCategoryListItem());
          } else if (snapshot.error != null) {
            print(snapshot.error);
            return const ErrorImage();
          } else {
            return Consumer<ShopDetailsProvider>(
                builder: (context, provider, child) {
              return SubcategoryListView(
                categories: provider.subCategories ?? [],
                selectedCategory: provider.selectedSubCategory,
                onSubCategorySelected: provider.onSubCategorySelected,
              );
            });
          }
        });
  }
}
