import 'package:core/model/category.dart';
import 'package:core/model/shop.dart';
import 'package:core/utils/utils.dart';
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

  void _showAlertDialog(ShopsProvider provider, Shop shop) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_shop".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.removeShop(shop);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    Category? category = Get.arguments;
    final provider = Provider.of<ShopsProvider>(context, listen: false);
    setupLoadingListener(provider.isLoading);
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
                            onLongPress: (shop) =>
                                _showAlertDialog(provider, shop),
                          ))),
              )
            ],
          )),
    );
  }
}
