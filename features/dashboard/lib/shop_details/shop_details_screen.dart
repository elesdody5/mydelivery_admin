
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'shop_details_provider.dart';
import 'widgets/products_list/products_list_view.dart';
import 'widgets/shop_details_card.dart';
import 'widgets/subcategories/subcategory_list_view.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final String? id = Get.arguments;
    final provider = Provider.of<ShopDetailsProvider>(context, listen: false);
    return Scaffold(
        body: FutureWithLoadingProgress(
            future: () => provider.init(id),
            child: Consumer<ShopDetailsProvider>(
                builder: (context, provider, child) {
              return Stack(children: [
                SizedBox(
                  height: Get.height,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey.shade300,
                                ),
                                placeholder: (_, __) => Container(
                                  color: Colors.grey.shade300,
                                ),
                                imageUrl: provider.shop?.imageUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          height: Get.height / 5,
                        ),
                        const Divider(height: 1,),
                        SizedBox(
                          height: 50,
                          child: SubcategoryListView(
                              categories: provider.subCategories ?? [],
                              selectedCategory: provider.selectedSubCategory,
                              onSubCategorySelected:
                                  provider.onSubCategorySelected),
                        ),
                        Expanded(
                          child: ProductsListView(
                            products: provider.currentSubCategoryProducts,

                          ),
                        ),
                      ]),
                ),
                Positioned(
                  width: Get.width,
                  top: Get.height / 8,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ShopDetailsCard(
                        openLocation: provider.openMap,
                        openWhatsapp: provider.openWhatsapp,
                        shop: provider.shop,
                        ),
                  ),
                )
              ]);
            })));
  }
}
