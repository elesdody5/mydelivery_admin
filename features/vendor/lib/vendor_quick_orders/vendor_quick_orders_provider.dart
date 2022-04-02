import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:vendor/data/repository/vendor_repository.dart';
import 'package:vendor/data/repository/vendor_repository_imp.dart';

class VendorQuickOrdersProvider extends BaseProvider {
  final VendorRepository _repository;
  List<QuickOrder> orders = [];

  VendorQuickOrdersProvider({VendorRepository? deliveryRepository})
      : _repository = deliveryRepository ?? VendorRepositoryImp();

  Future<void> getCurrentDeliveryOrders() async {
    Result<List<QuickOrder>> result =
        await _repository.getQuickOrderByUserId();
    if (result.succeeded()) {
      orders = result.getDataIfSuccess();
      notifyListeners();
    }
  }
}
