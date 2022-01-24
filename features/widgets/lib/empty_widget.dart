import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? subTitle;
  final void Function()? buttonAction;
  final String? buttonText;

  const EmptyWidget(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.buttonAction,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 1,
              ),
            ),
          ),
          Text(
            subTitle ?? "",
            style: const TextStyle(
              letterSpacing: 1,
              wordSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
