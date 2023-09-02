import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveryDetailsProvider extends BaseProvider {
  final DeliveryRepository _repository;

  var isUpdated = false;

  DeliveryDetailsProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();
  int coins = 0;
  bool isBlocked = false;

  Future<void> init(String deliveryId) async {
    await Future.wait([
      getDeliveryCoins(deliveryId),
      getDeliveryBlockState(deliveryId),
      checkLatestUpdate(deliveryId)
    ]);
  }

  Future<void> getDeliveryCoins(String deliveryId) async {
    coins = await _repository.getDeliveryCoins(deliveryId);
    notifyListeners();
  }

  Future<void> checkLatestUpdate(String deliveryId) async {
    Result<bool> result = await _repository.isUpdated(deliveryId);
    if (result.succeeded()) {
      isUpdated = result.getDataIfSuccess();
    }
  }

  Future<void> getDeliveryBlockState(String deliveryId) async {
    Result<User> result = await _repository.getRemoteUserDetails(deliveryId);
    if (result.succeeded()) {
      isBlocked = result.getDataIfSuccess().isBlocked;
      notifyListeners();
    }
  }

  Future<void> updateBlockState(String? id, isBlocked) async {
    if (id != null) {
      isLoading.value = true;
      Result result =
          await _repository.updatedDeliveryBlockStates(id, isBlocked);
      isLoading.value = false;
      if (result.succeeded()) {
        this.isBlocked = isBlocked;
      } else {
        errorMessage.value = "update_profile_error_message";
      }
      notifyListeners();
    }
  }

  void deleteUpdatedStatus(String? deliveryId) async {
    if (deliveryId != null) {
      isLoading.value = true;
      await _repository.removeIsUpdatedStatus(deliveryId);
      isLoading.value = false;
      isUpdated = false;
      notifyListeners();
    }
  }
}
