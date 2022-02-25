import 'package:core/model/category.dart';
import 'package:dashboard/shops/shops_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'widgets/shops_app_bar.dart';
import 'widgets/shops_grid_view.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Category? category = Get.arguments;
    final provider = Provider.of<ShopsProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          left: false,
          right: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ShopsAppBar(
                categoryName: category?.name ?? "",
                search: provider.search,
              ),
              FutureWithLoadingProgress(
                future: () => provider.getShopsByCategory(category?.id),
                child: Consumer<ShopsProvider>(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: EmptyWidget(
                        icon: Image.asset("assets/images/shops.png"),
                        title: "empty_shops_title".tr,
                        subTitle: "empty_shops_subtitle".tr,
                      ),
                    ),
                    builder: (_, provider, child) => provider.shops.isEmpty
                        ? child ?? Container()
                        : Expanded(
                            child: ShopsGridView(
                            shops: provider.filteredShops,
                          ))),
              )
            ],
          )),
    );
  }
}
