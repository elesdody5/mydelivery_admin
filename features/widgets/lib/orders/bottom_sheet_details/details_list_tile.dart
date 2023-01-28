import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../user_avatar.dart';

class DetailsListTile extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? address;
  final String? type;
  final String? latitude;
  final String? longitude;
  final String? phone;

  const DetailsListTile(
      {Key? key,
      this.imageUrl,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.type,
      this.phone})
      : super(key: key);

  Future<void> _openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(id: "", imageUrl: imageUrl),
      title: Text(name ?? ""),
      subtitle: Text(type ?? ""),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (latitude != null && longitude != null)
            InkWell(
              onTap: () => _openMap(),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.location_on,
                  color: Get.theme.primaryIconTheme.color,
                  size: 20,
                ),
              ),
            ),
          InkWell(
            onTap: () => launch("tel://$phone"),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
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
