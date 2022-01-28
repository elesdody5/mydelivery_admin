import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileIcon extends StatelessWidget {
  final String? imageUrl;

  const UserProfileIcon({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null)
        ? const CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(
              Icons.person_outline_rounded,
              size: 50,
            ),
          )
        : CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(imageUrl ?? ""),
          );
  }
}
