import 'package:quickorder/data/local/dao/quick_order_dao.dart';
import 'package:quickorder/data/local/entity/local_quick_order.dart';

class QuickOrderLocalDataSource {
  final QuickOrderDao _dao;

  QuickOrderLocalDataSource({QuickOrderDao? dao})
      : _dao = dao ?? QuickOrderDao();

  Future<int> insertQuickOrder(LocalQuickOrder quickOrder) {
    return _dao.insertQuickOrder(quickOrder);
  }

  Future<LocalQuickOrder?> getQuickOrder(int id) {
    return _dao.getQuickOrder(id);
  }

  Future<void> deleteQuickOrder(int id) {
    return _dao.deleteQuickOrder(id);
  }
}
