import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickOrderDetails extends StatelessWidget {
  final QuickOrder quickOrder;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;

  const QuickOrderDetails(
      {Key? key, required this.quickOrder, this.pickOrder, this.deliverOrder})
      : super(key: key);

  ImageProvider _imageProvider() {
    if (quickOrder.user?.imageUrl == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return CachedNetworkImageProvider(
        quickOrder.user?.imageUrl ?? "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "description".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              quickOrder.description ?? "",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: _imageProvider(),
            ),
            title: Text(quickOrder.user?.name ?? ""),
            subtitle: Text(quickOrder.address ?? ""),
            trailing: IconButton(
              onPressed: () => launch("tel://${quickOrder.user?.phone}"),
              icon: Icon(
                Icons.phone,
                color: Get.theme.primaryIconTheme.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
