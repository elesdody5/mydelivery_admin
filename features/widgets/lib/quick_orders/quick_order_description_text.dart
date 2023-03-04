import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickOrderDescriptionText extends StatelessWidget {
  final String? description;

  QuickOrderDescriptionText({Key? key, this.description}) : super(key: key);

  var numberRegex = RegExp(r'[0-9]');

  @override
  Widget build(BuildContext context) {
    if (description?.contains(numberRegex) != true) {
      return SelectableText(
        description ?? "",
        style: const TextStyle(fontSize: 15),
      );
    } else {
      return SelectableText.rich(
        TextSpan(
            children: description?.split(" ").map((text) {
          if (numberRegex.hasMatch(text) && text.length >= 11) {
            return TextSpan(
                text: "$text ",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      launch("tel://${text.replaceAll(RegExp(r"\D"), "")}"));
          } else {
            return TextSpan(
              text: "$text ",
              style: const TextStyle(fontSize: 15),
            );
          }
        }).toList()),
      );
    }
  }
}
