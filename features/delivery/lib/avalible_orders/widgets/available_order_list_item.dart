import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableOrderListItem extends StatelessWidget {
  final User? user;
  final Function(String) onTap;

  const AvailableOrderListItem(
      {Key? key, required this.user, required this.onTap})
      : super(key: key);

  ImageProvider _imageProvider() {
    if (user?.imageUrl == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return CachedNetworkImageProvider(
        user?.imageUrl ?? "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(user?.id ?? ""),
      leading: CircleAvatar(
        backgroundImage: _imageProvider(),
      ),
      title: Text(user?.name ?? ""),
      subtitle: Text(user?.address ?? ""),
      trailing: const Icon(CupertinoIcons.forward),
    );
  }
}
