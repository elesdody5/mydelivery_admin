import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';
import 'package:core/domain/city.dart';

class CitiesDialogProvider extends BaseProvider {
  final Repository _repository;
  List<City> cities = [];
  City currentCity = City();

  CitiesDialogProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getCities() async {
    Result result = await _repository.getCities();
    if (result.succeeded()) {
      cities = result.getDataIfSuccess();
      print(cities);
      notifyListeners();
    }
  }

  Future<void> addNewCity() async {
    isLoading.value = true;
    Result result;
    if (currentCity.id == null) {
      result = await _repository.addNewCity(currentCity);
    } else {
      result = await _repository.updateCity(currentCity);
    }
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "city_added_successfully";
    } else {
      errorMessage.value = "city_added_error";
    }
  }
}
