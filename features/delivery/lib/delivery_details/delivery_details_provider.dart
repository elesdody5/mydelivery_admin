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
  bool isAdminBlocked = false;
  bool isAddressHidden = false;
  User? delivery;

  Future<void> init(User? delivery) async {
    this.delivery = delivery;
    await Future.wait([
      getDeliveryCoins(delivery?.id),
      getDeliveryBlockState(delivery?.id),
      getAddressVisibilityState(delivery?.id)
    ]);
  }

  Future<void> getDeliveryCoins(String? deliveryId) async {
    if (deliveryId != null) {
      coins = await _repository.getDeliveryCoins(deliveryId);
    }
    notifyListeners();
  }

  Future<void> getDeliveryBlockState(String? deliveryId) async {
    if (deliveryId != null) {
      Result<User> result = await _repository.getRemoteUserDetails(deliveryId);
      if (result.succeeded()) {
        isBlocked = result
            .getDataIfSuccess()
            .isBlocked;
        isAdminBlocked = result
            .getDataIfSuccess()
            .isAdminBlocked ?? false;
        notifyListeners();
      }
    }
  }

  Future<void> getAddressVisibilityState(String? deliveryId) async {
    if (deliveryId != null) {
      Result<bool> result = await _repository.isAddressHidden(deliveryId);
      if (result.succeeded()) {
        isAddressHidden = result.getDataIfSuccess();
        notifyListeners();
      }
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

  Future<void> updateAdminBlockState(String? id, isAdminBlocked) async {
    if (id != null) {
      isLoading.value = true;
      Result result =
      await _repository.updatedDeliveryAdminBlockState(id, isAdminBlocked);
      isLoading.value = false;
      if (result.succeeded()) {
        this.isAdminBlocked = isAdminBlocked;
      } else {
        errorMessage.value = "update_profile_error_message";
      }
      notifyListeners();
    }
  }

  Future<void> updateAddressVisibilityState(String? id, bool isHidden) async {
    if (id != null) {
      isLoading.value = true;
      Result result =
      await _repository.updateAddressVisibilityState(id, isHidden);
      isLoading.value = false;
      if (result.succeeded()) {
        isAddressHidden = isHidden;
      } else {
        errorMessage.value = "update_profile_error_message";
      }
      notifyListeners();
    }
  }

  void updateTotalDeliveredOrder() async {
    var result = await _repository.getRemoteUserDetails(delivery?.id ?? "");
    if(result.succeeded()) delivery = result.getDataIfSuccess();
    notifyListeners();
  }

  Future<void> updateBalance(double amount) async {
    var accountBalance = (delivery?.accountBalance ?? 0) + amount;
    isLoading.value = true;
    Result result = await _repository.updateDeliveryAccountBalance(
        delivery?.id ?? "", accountBalance);
    isLoading.value = false;
    if (result.succeeded()) {
      delivery?.accountBalance = accountBalance;
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }
}
