import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/quick_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets/user_avatar.dart';

class QuickOrderDetails extends StatelessWidget {
  final QuickOrder quickOrder;

  const QuickOrderDetails({
    Key? key,
    required this.quickOrder,
  }) : super(key: key);

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
      child: SingleChildScrollView(
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
                      "${"order_places_count".tr} (${quickOrder.count})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
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
              leading: UserAvatar(
                id: quickOrder.delivery?.id ?? "",
                imageUrl: quickOrder.delivery?.imageUrl,
              ),
              title: quickOrder.delivery?.name != null
                  ? Text(quickOrder.delivery?.name ?? "")
                  : Text("no_delivery".tr),
              subtitle: Text(quickOrder.address ?? ""),
              trailing: IconButton(
                onPressed: () {
                  if (quickOrder.delivery?.name != null) {
                    launch("tel://${quickOrder.delivery?.phone}");
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
      ),
    );
  }
}
