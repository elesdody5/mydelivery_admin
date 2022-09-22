import 'package:core/domain/user.dart';

class Review {
  String? id;
  String? delivery;
  double? rating;
  String? reviewBody;
  User? user;

  Review({
    this.id,
    this.delivery,
    this.rating,
    this.reviewBody,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        delivery: json["delivery"],
        rating: json["rating"],
        reviewBody: json["reviewBody"],
        user: User.fromJson(json["reviewPoster"]),
      );
}
