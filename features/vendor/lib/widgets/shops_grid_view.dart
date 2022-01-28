import 'package:core/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'shop_list_item.dart';

class ShopsGridView extends StatelessWidget {
  final List<Shop> shops;
  final Function(Shop) onLongTap;

  const ShopsGridView({Key? key, required this.shops, required this.onLongTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4),
          itemCount: shops.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
              columnCount: 3,
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: ShopListItem(
                      shop: shops[index],
                  onLongTap: onLongTap,
                )),
              )),
        ),
      );
}
