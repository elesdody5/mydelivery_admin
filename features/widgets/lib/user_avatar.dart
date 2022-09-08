import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class UserAvatar extends StatelessWidget {
  final String id;
  final String? imageUrl;
  final double? radius;
  const UserAvatar({Key? key, required this.id, this.imageUrl,this.radius}) : super(key: key);

  ImageProvider _imageProvider() {
    if (imageUrl == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return CachedNetworkImageProvider(
        imageUrl ?? "",
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: _imageProvider(),
      ),
    );
  }
}
