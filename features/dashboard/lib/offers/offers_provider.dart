

import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/offer.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class OffersProvider extends BaseProvider {
  List<Offer> offers = [];
  final Repository _repository;

  OffersProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getOffers() async {
    Result<List<Offer>> result = await _repository.getOffers();
    if (result.succeeded()) {
      offers = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> deleteOfferById(Offer offer) async {
    isLoading.value = true;
    Result result = await _repository.deleteOffer(offer.id!);
    if (result.succeeded()) {
      offers.remove(offer);
      isLoading.value = false;
      notifyListeners();
    }
  }
}
