import 'package:delivery/delivery_reviews/widgets/review_list_item.dart';
import 'package:flutter/material.dart';
import 'package:core/model/review.dart';

class ReviewsListView extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsListView({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ReviewListItem(review: reviews[index]),
      itemCount: reviews.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
