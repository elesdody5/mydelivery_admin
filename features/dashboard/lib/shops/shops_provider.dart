import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class ShopsProvider extends BaseProvider {
  final Repository _repository;
  List<Shop> shops = [];
  List<Shop> filteredShops = [];

  ShopsProvider({Repository? productsRepository})
      : _repository = productsRepository ?? MainRepository();

  Future<void> getShopsByCategory(String? categoryId) async {
    if (categoryId != null) {
      Result<List<Shop>> result =
          await _repository.getShopsByCategory(categoryId);
      if (result.succeeded()) {
        shops = result.getDataIfSuccess();
        filteredShops = [...shops];
        notifyListeners();
      }
    }
  }

  void search(String value) {
    if (value.isNotEmpty) {
      filteredShops = shops.where((element) {
        return element.name?.toLowerCase().contains(value) ?? false;
      }).toList();
    } else {
      filteredShops = [...shops];
    }
    notifyListeners();
  }
}
