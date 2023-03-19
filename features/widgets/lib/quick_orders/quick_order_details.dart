import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets/record/quick_order_record_player.dart';
import 'package:widgets/user_avatar.dart';

import 'quick_order_description_text.dart';

class QuickOrderDetails extends StatelessWidget {
  final QuickOrder quickOrder;
  final Function(QuickOrder)? pickOrder;
  final Function(QuickOrder)? deliverOrder;

  const QuickOrderDetails(
      {Key? key, required this.quickOrder, this.pickOrder, this.deliverOrder})
      : super(key: key);

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

  void _playRecord() =>
      Get.dialog(QuickOrderRecordPlayer(audioUrl: quickOrder.audioUrl ?? ""));

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
              child: QuickOrderDescriptionText(
                  description: quickOrder.description),
            ),
            const Divider(
              thickness: 1,
            ),
            if (quickOrder.delivery != null)
              ListTile(
                leading: UserAvatar(
                    id: quickOrder.delivery?.id ?? "",
                    imageUrl: quickOrder.delivery?.imageUrl),
                title: Text(quickOrder.delivery?.name ?? ""),
                subtitle: quickOrder.deliveryPickedTime != null
                    ? Text("delivery_picked_time".trParams(
                        {"hour": quickOrder.deliveryPickedTime!.timeFormat()}))
                    : null,
                trailing: IconButton(
                  onPressed: () {
                    launch("tel://${quickOrder.delivery?.phone}");
                  },
                  icon: Icon(
                    Icons.phone,
                    color: Get.theme.primaryIconTheme.color,
                  ),
                ),
              ),
            if (quickOrder.delivery != null)
              const Divider(
                thickness: 1,
              ),
            ListTile(
              leading: UserAvatar(
                  id: quickOrder.user?.id ?? "",
                  imageUrl: quickOrder.user?.imageUrl),
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
            if (quickOrder.audioUrl != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _playRecord, child: Text("play_record".tr)),
              ),
          ],
        ),
      ),
    );
  }
}
