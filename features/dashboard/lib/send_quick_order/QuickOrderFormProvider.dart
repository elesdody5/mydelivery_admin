import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/shop.dart';

import '../data/repository/repository.dart';
import '../data/repository/repository_imp.dart';


class QuickOrderFormProvider extends BaseProvider {
  final Repository _repository;
  QuickOrder quickOrder = QuickOrder();
  User? user;
  Shop? shop;

  QuickOrderFormProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> sendQuickOrder() async {
    if (shop != null) {
      isLoading.value = true;
      quickOrder.dateTime = DateTime.now();
      Result result = await _repository.sendQuickOrder(quickOrder);
      isLoading.value = false;
      if (result.succeeded()) {
        successMessage.value = "quick_order_successfully";
      } else {
        errorMessage.value = "something_went_wrong";
      }
      quickOrder = QuickOrder();
    }
  }
}
