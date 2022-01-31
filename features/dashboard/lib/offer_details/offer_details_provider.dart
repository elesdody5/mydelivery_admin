import 'dart:io';

import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class OfferDetailsProvider extends BaseProvider {
  final Repository _repository;

  Offer offer = Offer();
  List<Shop> shops = [];

  OfferDetailsProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  void initOffer(Offer offer) {
    this.offer = offer;
    notifyListeners();
  }

  void onImageSelected(File pickedFile) {
    offer.imageFile = pickedFile;
    notifyListeners();
  }

  Future<void> getAllShops() async {
    Result<List<Shop>> shops = await _repository.getAllShops();
    if (shops.succeeded()) {
      this.shops = shops.getDataIfSuccess();
      notifyListeners();
    }
  }

  Future<void> addOrUpdateOffer() async {
    isLoading.value = true;
    Result? result;
    if (offer.id == null) {
      result = await _repository.addOffer(offer);
    } else {
      // result = await _repository.updateOffer(offer);
    }
    isLoading.value = false;
    if (result?.succeeded() == true) {
      successMessage.value = "added_successfully";
    } else {
      errorMessage.value = "add_error_message";
    }
  }
}
