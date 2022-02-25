import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/category.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class CategoriesProvider extends BaseProvider {
  final Repository _repository;
  List<Category> categoryList = [];

  CategoriesProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getAllCategory() async {
    Result<List<Category>> result = await _repository.getAllCategory();
    if (result.succeeded()) {
      categoryList = result.getDataIfSuccess();
      notifyListeners();
    }
  }
}
