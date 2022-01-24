import 'package:core/domain/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseProvider with ChangeNotifier {
  RxnString errorMessage = RxnString("");
  RxnString successMessage = RxnString("");
  var isLoading = false.obs;
  Rxn<NavigationDestination> navigation = Rxn(null);
}

extension ClearRxnString on RxnString {
  void clear() {
    value = null;
  }
}

extension ClearRxn on Rxn<NavigationDestination> {
  void clear() {
    value = null;
  }
}
