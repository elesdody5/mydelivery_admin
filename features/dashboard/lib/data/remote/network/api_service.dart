import 'package:core/model/offer.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';

abstract class ApiService {
  Future<ApiResponse> getAllUsers();

  Future<ApiResponse<List<Offer>>> getAllOffers();

  Future<ApiResponse> deleteOffer(String offerId);

  Future<ApiResponse> addOffer(Offer offer);

  Future<ApiResponse<List<Shop>>> getAllShops();
}
