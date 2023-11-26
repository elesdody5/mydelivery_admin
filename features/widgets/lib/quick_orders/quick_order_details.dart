import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/address.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user_type.dart';
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

  Widget addressWidget(Address? address) {
    return address?.fullAddress != null
        ? Text(
            address!.fullAddress!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${"from".tr} : ${quickOrder.address?.startDestination ?? ""}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${"to".tr} : ${quickOrder.address?.endDestination ?? ""}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (quickOrder.address != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "address".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: addressWidget(quickOrder.address),
            ),
            const Divider(
              thickness: 1,
            ),
            if (quickOrder.phoneNumber != null &&
                quickOrder.phoneNumber?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("contact_number".tr),
                    TextButton(
                      onPressed: () => launchUrl(
                          Uri.parse("tel://${quickOrder.phoneNumber}")),
                      child: Text(
                        quickOrder.phoneNumber?.replaceAll(" ", "") ?? "",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
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
            if (quickOrder.user?.userType == UserType.user)
              ListTile(
                leading: UserAvatar(
                    id: quickOrder.user?.id ?? "",
                    imageUrl: quickOrder.user?.imageUrl),
                title: quickOrder.user?.name != null
                    ? Text(quickOrder.user?.name ?? "")
                    : Text(
                        quickOrder.phoneNumber ?? "",
                      ),
                subtitle: Text(quickOrder.user?.address ?? ""),
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
            if (quickOrder.user?.userType == UserType.user)
              const Divider(
                thickness: 1,
              ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    if (quickOrder.user?.userType != UserType.user)
                      Text(
                        quickOrder.user?.name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    Text(
                      "${"order_places_count".tr} (${quickOrder.count ?? 1})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuickOrderDescriptionText(
                  description: quickOrder.description),
            ),
            const Divider(
              thickness: 1,
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
