import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfferImagePicker extends StatelessWidget {
  final File? selectedImage;
  final void Function(File) onImageSelected;
  final String? imageUrl;

  const OfferImagePicker(
      {Key? key,
      required this.onImageSelected,
      this.selectedImage,
      this.imageUrl})
      : super(key: key);

  Future<void> _pickImage() async {
    XFile? imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }
    onImageSelected(File(imageFile.path));
  }

  Widget _buildImageWidget() {
    if (selectedImage != null) {
      return SizedBox(
        width: 300,
        height: 150,
        child: Image.file(
          selectedImage!,
          fit: BoxFit.cover,
        ),
      );
    } else if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: const [
            Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
            Text(
              "upload photo",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickImage(),
      child: Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400)),
          child: _buildImageWidget()),
    );
  }
}
