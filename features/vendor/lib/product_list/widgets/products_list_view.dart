import 'package:core/model/product.dart';
import 'package:flutter/material.dart';
import 'package:vendor/product_list/widgets/product_list_item.dart';

class ProductsListView extends StatelessWidget {
  final List<Product> products;
  final Function(Product) removeProduct;
  final Function(Product) onProductTap;

  const ProductsListView(
      {Key? key,
      required this.products,
      required this.removeProduct,
      required this.onProductTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductListItem(
              product: products[index],
              removeProduct: removeProduct,
              onProductTap: onProductTap,
            ));
  }
}
