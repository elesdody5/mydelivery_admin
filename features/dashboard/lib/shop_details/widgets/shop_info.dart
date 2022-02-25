import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ShopInfo extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final void Function() onTap;

  const ShopInfo({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: icon),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
