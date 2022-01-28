import 'package:core/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubcategoryListViewChip extends StatelessWidget {
  const SubcategoryListViewChip({
    Key? key,
    required this.isSelected,
    required this.subCategory,
    required this.onChipSelected,
    required this.onChipLongTap,
  }) : super(key: key);

  final bool? isSelected;
  final Category? subCategory;
  final Function(Category?)? onChipSelected;
  final Function(Category?)? onChipLongTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChipSelected != null) onChipSelected!(subCategory);
      },
      onLongPress: () {
        if (onChipLongTap != null) onChipLongTap!(subCategory);
      },
      child: Chip(
        backgroundColor:
            isSelected == true ? Get.theme.primaryColor : Colors.grey.shade300,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        label: Text(
          subCategory?.name ?? "       ",
        ),
      ),
    );
  }
}
