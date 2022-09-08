import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/quick_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'quick_order_description_text.dart';

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

  void _showImagePreview() => Get.dialog(
        CachedNetworkImage(
          imageUrl: quickOrder.imageUrl ?? "",
          fit: BoxFit.contain,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          imageBuilder: (context, provider) => InteractiveViewer(
              panEnabled: false,
              // Set it to false to prevent panning.
              child: Container(
                decoration:
                    BoxDecoration(image: DecorationImage(image: provider)),
              )),
        ),
      );

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "description".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "${"order_places_count".tr} (${quickOrder.count ?? "1"})",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuickOrderDescriptionText(description: quickOrder.description),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: _imageProvider(),
            ),
            title: quickOrder.user?.name != null
                ? Text(quickOrder.user?.name ?? "")
                : Text(
                    quickOrder.phoneNumber ?? "",
                  ),
            subtitle: Text(quickOrder.address ?? ""),
            trailing: IconButton(
              onPressed: () {
                if (quickOrder.user?.name != null) {
                  launch("tel://${quickOrder.user?.phone}");
                } else {
                  launch("tel://${quickOrder.phoneNumber}");
                }
              },
              icon: Icon(
                Icons.phone,
                color: Get.theme.primaryIconTheme.color,
              ),
            ),
          ),
          if (quickOrder.imageUrl != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _showImagePreview, child: Text("view_image".tr)),
            ),
        ],
      ),
    );
  }
}
