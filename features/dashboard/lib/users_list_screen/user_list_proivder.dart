import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/screens.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class UsersListProvider extends BaseProvider {
  List<User> usersList = [];
  final Repository _repository;

  UsersListProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> getAllUsers() async {
    Result<List<User>> result = await _repository.getAllUsers();
    if (result.succeeded()) {
      usersList = result.getDataIfSuccess();
      notifyListeners();
    }
  }

  void onUserClicked(String id) async {
    isLoading.value = true;
    await _repository.saveCurrentUserId(id);
    isLoading.value = false;
    navigation.value = NavigationDestination(routeName: profileScreenRouteName);
  }
}
