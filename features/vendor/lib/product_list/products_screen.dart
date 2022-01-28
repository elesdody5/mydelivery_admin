import 'package:core/model/category.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';
import 'package:core/screens.dart';
import 'package:core/utils/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/product_list/products_provider.dart';
import 'package:vendor/product_list/widgets/products_list_view.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'widgets/subcategories/subcategory_list_view.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Shop? shop = Get.arguments;
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(shop?.name ?? ""),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: FutureWithLoadingProgress(
            future: () => provider.init(shop),
            child:
                Consumer<ProductsProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: SubcategoryListView(
                        categories: provider.subCategories,
                        selectedCategory: provider.selectedSubCategory,
                        onSubCategorySelected: provider.onSubCategorySelected,
                        onSubCategoryLongTap: (subCategory) => {}),
                  ),
                  Expanded(
                    child: ProductsListView(
                        products: provider.currentSubCategoryProducts,
                        removeProduct: provider.removeProduct,
                        onProductTap: (Product product) => {}),
                  ),
                ],
              );
            })),
      ),
    );
  }
}
