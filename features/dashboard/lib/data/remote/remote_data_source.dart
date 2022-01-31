import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/shop.dart';

abstract class RemoteDataSource {
  Future<Result<List<User>>> getAllUsers();

  Future<Result<List<Offer>>> getAllOffers();

  Future<Result> deleteOffer(String offerId);

  Future<Result> addOffer(Offer offer);

  Future<Result<List<Shop>>> getAllShops();
}
