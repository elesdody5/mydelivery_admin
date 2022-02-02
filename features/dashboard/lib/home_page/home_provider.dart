import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';
import 'package:dashboard/domain/model/order_settings.dart';

class HomeProvider extends BaseProvider {
  final Repository _repository;
  OrderSettings? orderSettings;

  HomeProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getSettings() async {
    if (orderSettings == null) {
      isLoading.value = true;
      Result result = await _repository.getOrderSettings();
      isLoading.value = false;
      if (result.succeeded()) {
        orderSettings = result.getDataIfSuccess();
        notifyListeners();
      }
    }
  }

  Future<void> updateSettings() async {
    if (orderSettings != null) {
      isLoading.value = true;
      await _repository.updateOrderSettings(orderSettings!);
      isLoading.value = false;
    }
  }
}
