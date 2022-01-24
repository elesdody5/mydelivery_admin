import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:delivery/data/repository/delivery_repository.dart';
import 'package:delivery/data/repository/delivery_repository_imp.dart';

class DeliveryListProvider extends BaseProvider {
  List<User> deliveryList = [];
  DeliveryRepository _repository;

  DeliveryListProvider({DeliveryRepository? repository})
      : _repository = repository ?? DeliveryRepositoryImp();

  Future<void> getAllDelivery() async {
    Result<List<User>> result = await _repository.getAllDelivery();
    if (result.succeeded()) {
      deliveryList = result.getDataIfSuccess();
      notifyListeners();
    }
  }
}
