import 'package:core/model/category.dart';
import 'package:flutter/material.dart';

import 'subcategory_list_view_chip.dart';

class SubcategoryListView extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category?) onSubCategorySelected;
  final Function(Category?) onSubCategoryLongTap;

  const SubcategoryListView(
      {Key? key,
      required this.categories,
      required this.selectedCategory,
      required this.onSubCategorySelected,
      required this.onSubCategoryLongTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubcategoryListViewChip(
                  onChipSelected: onSubCategorySelected,
                  isSelected: selectedCategory == categories[index],
                  subCategory: categories[index],
                  onChipLongTap: onSubCategoryLongTap),
            ));
  }
}
