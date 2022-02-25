import 'package:core/model/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'product_list_item.dart';
class ProductsListView extends StatelessWidget {
  final List<CartItem> products;


  const ProductsListView(
      {Key? key,
      required this.products,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductListItem(
              cartItem: products[index],

            ));
  }
}
