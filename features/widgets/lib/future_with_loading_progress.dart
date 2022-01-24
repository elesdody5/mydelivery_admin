import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureWithLoadingProgress extends StatelessWidget {
  final Function future;
  final Widget child;

  const FutureWithLoadingProgress(
      {Key? key, required this.future, required this.child})
      : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CupertinoActivityIndicator(
                radius: 15,
                // valueColor:
                //     new AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
              ),
            ));
          } else {
            return child;
          }
        });
  }
}
