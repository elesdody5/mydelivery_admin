import 'package:core/base_provider.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveryDetailsProvider extends BaseProvider {
  final DeliveryRepository _repository;

  DeliveryDetailsProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();
  int coins = 0;

  Future<void> getDeliveryCoins(String deliveryId) async {
    coins = await _repository.getDeliveryCoins(deliveryId);
    notifyListeners();
  }
}
