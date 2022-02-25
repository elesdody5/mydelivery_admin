
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'subcategory_list_view_chip.dart';

class ShimmerSubCategoryListItem extends StatelessWidget {
  const ShimmerSubCategoryListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const SizedBox(
          width: 60,
          height: 60,
          child: SubcategoryListViewChip(
              isSelected: false, subCategory: null, onChipSelected: null),
        ),
      ),
    );
  }
}
