import 'package:core/domain/user.dart';
import 'package:delivery/delivery_reviews/delivery_reviews_provider.dart';
import 'package:delivery/delivery_reviews/widgets/rating_text.dart';
import 'package:flutter/material.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'package:widgets/user_avatar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeliveryReviewsScreen extends StatelessWidget {
  const DeliveryReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User delivery = Get.arguments;
    final provider =
    Provider.of<DeliveryReviewsProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: FutureWithLoadingProgress(
          future: () => provider.getAllReviews(delivery.id),
          child: Consumer<DeliveryReviewsProvider>(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserAvatar(
                  id: delivery.id ?? "",
                  imageUrl: delivery.imageUrl,
                  radius: 50,
                ),
              ),
              builder: (key, provider, child) {
                return Column(
                  children: [
                    child ?? Container(),
                    DeliveryRatingBar(ratingAverage: provider.average),
                    const Divider(),
                    if(provider.reviews.isEmpty)
                      EmptyWidget(title: "no_reviews".tr,
                        icon: const Icon(
                          Icons.star, color: Colors.amber, size: 50,),),
                    if(provider.reviews.isNotEmpty)
                      Expanded(child: ListView())
                  ],
                );
              }),
        ),
      ),
    );
  }
}
