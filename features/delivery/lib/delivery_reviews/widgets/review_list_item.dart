import 'package:core/model/review.dart';
import 'package:flutter/material.dart';
import 'package:widgets/user_avatar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewListItem extends StatelessWidget {
  final Review review;

  const ReviewListItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(
        id: review.user?.id ?? "",
        imageUrl: review.user?.imageUrl,
      ),
      title: Text(review.user?.name ?? ""),
      subtitle: Text(review.reviewBody ?? ""),
      trailing: RatingBarIndicator(
        rating: review.rating?.toDouble() ?? 0,
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 50.0,
      ),
    );
  }
}
