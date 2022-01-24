import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.cloud_off,
            size: 100,
          ),
          Text(
            "something_went_wrong".tr,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
