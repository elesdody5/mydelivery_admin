import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveryListProvider extends BaseProvider {
  List<User> deliveryList = [];
  final DeliveryRepository _repository;

  DeliveryListProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getAllDelivery() async {
    Result<List<User>> result = await _repository.getAllDelivery();
    if (result.succeeded()) {
      deliveryList = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  void onDeliveryClicked(String id) async {
    isLoading.value = true;
    await _repository.saveCurrentUserId(id);
    isLoading.value = false;
    navigation.value = NavigationDestination(routeName: deliveryHomeScreen);
  }

  Future<void> removeDelivery(User delivery) async {
    isLoading.value = true;
    Result result = await _repository.removeUserById(delivery.id ?? "");
    isLoading.value = false;
    if (result.succeeded()) {
      deliveryList.remove(delivery);
      notifyListeners();
    }
  }
}
