import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class UserAvatar extends StatelessWidget {
  final String id;
  final String? imageUrl;
  final double? radius;

  const UserAvatar({Key? key, required this.id, this.imageUrl, this.radius})
      : super(key: key);

  ImageProvider _imageProvider() {
    if (imageUrl == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return CachedNetworkImageProvider(
        imageUrl ?? "",
      );
    }
  }

  void _showImagePreview() => Get.dialog(
        CachedNetworkImage(
          imageUrl: imageUrl ?? 'assets/images/profile.png',
          fit: BoxFit.contain,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, _) => const CupertinoActivityIndicator(),
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
    return Hero(
      tag: id,
      child: InkWell(
        onTap: _showImagePreview,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: _imageProvider(),
        ),
      ),
    );
  }
}
