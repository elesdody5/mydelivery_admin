import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/offer.dart';

abstract class Repository {
  Future<Result<List<User>>> getAllUsers();

  Future<void> saveCurrentUserId(String id);

  Future<Result<List<Offer>>> getOffers();

  Future<Result> deleteOffer(String offerId);

  Future<Result> addOffer(Offer offer);
}
