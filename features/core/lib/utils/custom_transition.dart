import 'package:core/utils/circle_reveal_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CircleRevealClipperTransition implements CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var screenSize = Get.size;
    Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
    double beginRadius = 0.0;
    double endRadius = screenSize.height * 1.2;

    var tween = Tween<double>(begin: beginRadius, end: endRadius);
    Animation<double> radiusTweenAnimation = animation.drive(tween);

    return ClipPath(
      clipper: CircleRevealClipper(
          radius: radiusTweenAnimation.value, center: center),
      child: child,
    );
  }
}
