import 'package:core/domain/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/user_type.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Function(String?) onTap;

  const UserListItem({Key? key, required this.user, required this.onTap})
      : super(key: key);

  ImageProvider _imageProvider() {
    if (user.imageUrl == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return CachedNetworkImageProvider(
        user.imageUrl ?? "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          onTap: () => onTap(user.id),
          leading: Hero(
            tag: user.id!,
            child: CircleAvatar(
              backgroundImage: _imageProvider(),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              user.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          subtitle: Text(user.userType?.enmToString() ?? ""),
          trailing: const IconButton(
            icon: Icon(Icons.phone),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
