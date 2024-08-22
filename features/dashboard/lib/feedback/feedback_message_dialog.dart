import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feedback_phones_dialog.dart';

class FeedbackMessageDialog extends StatelessWidget {
  FeedbackMessageDialog({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = "feedback_message".tr;
    return AlertDialog(
      title: const Text("Feedback"),
      content: TextField(
        enableSuggestions: true,
        minLines: 3,
        maxLines: 6,
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
              Get.dialog(FeedbackPhonesDialog(), arguments: _controller.text);
            },
            child: Text("send".tr))
      ],
    );
  }
}
