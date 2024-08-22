import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPhonesDialog extends StatelessWidget {
  FeedbackPhonesDialog({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  void sendMessage(String message, String phone) {
    var whatsMessage = Uri.encodeComponent(message);
    var whatsappUrl = "whatsapp://send?phone=+2$phone"
        "&text=$whatsMessage";

    launch(whatsappUrl);
  }

  @override
  Widget build(BuildContext context) {
    var message = Get.arguments;
    return AlertDialog(
        title: Text("add_phone".tr),
        content: TextField(
          enableSuggestions: true,
          maxLines: 1,
          keyboardType: TextInputType.phone,
          controller: _controller,
        ),
        actions: [
          TextButton(
            child: Text("cancel".tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
              onPressed: () {
                Get.back();
                sendMessage(message, _controller.text);
              },
              child: Text("send".tr))
        ]);
  }
}
