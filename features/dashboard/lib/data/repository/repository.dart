import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/domain/model/order_settings.dart';

abstract class Repository {
  Future<Result<List<User>>> getAllUsers();

  Future<void> saveCurrentUserId(String id);

  Future<Result<List<Offer>>> getOffers();

  Future<Result> deleteOffer(String offerId);

  Future<Result> addOffer(Offer offer);

  Future<Result<List<Shop>>> getAllShops();

  Future<Result<OrderSettings>> getOrderSettings();
  Future<Result> updateOrderSettings(OrderSettings orderSettings);
}
