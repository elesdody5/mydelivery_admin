import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopsAppBar extends StatelessWidget {
  final String? categoryName;
  final Function(String) search;

  const ShopsAppBar(
      {Key? key, required this.categoryName, required this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.isDarkMode ? Get.theme.cardColor : Get.theme.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
              title: Text(categoryName ?? ""),
              trailing: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_forward,
                  ))),
          CupertinoSearchTextField(
            backgroundColor: Colors.white,
            placeholder: 'search_hint'.tr,
            onChanged: (value) => search(value),
          ),
        ],
      ),
    );
  }
}
