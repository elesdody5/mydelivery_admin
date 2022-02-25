import 'package:core/model/category.dart';
import 'package:dashboard/categories/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';

import 'widgets/category_list_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("order".tr),
          backgroundColor: Get.theme.primaryColor,
        ),
        body: SafeArea(
          child: FutureWithLoadingProgress(
            future: Provider.of<CategoriesProvider>(context, listen: false)
                .getAllCategory,
            child: Consumer<CategoriesProvider>(
                builder: (context, provider, child) {
              return AnimationLimiter(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredGrid(
                          columnCount: 3,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                                child: CategoryListItem(
                                    provider.categoryList[index])),
                          )),
                ),
              );
            }),
          ),
        ));
  }
}
