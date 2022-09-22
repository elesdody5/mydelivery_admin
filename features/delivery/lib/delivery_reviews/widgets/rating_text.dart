import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DeliveryRatingBar extends StatelessWidget {
  final double ratingAverage;

  const DeliveryRatingBar({Key? key, required this.ratingAverage})
      : super(key: key);

  String ratingValue(double ratingAverage) {
    if (ratingAverage > 4 && ratingAverage <= 5) return "excellent".tr;
    if (ratingAverage > 3 && ratingAverage <= 4) return "very_good".tr;
    if (ratingAverage > 2 && ratingAverage <= 3) return "good".tr;
    if (ratingAverage > 1 && ratingAverage <= 2) return "bad".tr;
    if (ratingAverage <= 1 && ratingAverage > 0) return "very_bad".tr;
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: ratingAverage,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$ratingAverage",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
        Text(
          ratingValue(ratingAverage),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
