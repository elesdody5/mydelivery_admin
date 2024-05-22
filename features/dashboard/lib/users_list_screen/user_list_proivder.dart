import 'package:core/base_provider.dart';
import 'package:core/domain/navigation.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/res.dart';
import 'package:core/screens.dart';
import 'package:dashboard/data/repository/repository.dart';
import 'package:dashboard/data/repository/repository_imp.dart';

class UsersListProvider extends BaseProvider {
  List<User> users = [];
  List<User> filteredUsers = [];
  final Repository _repository;

  UsersListProvider({Repository? repository})
      : _repository = repository ?? MainRepository();
  UserType? selectedUserType;

  Future<void> getAllUsers() async {
    Result<List<User>> result = await _repository.getAllUsers();
    if (result.succeeded()) {
      users = result.getDataIfSuccess();
      filteredUsers = [...users];
      notifyListeners();
    }
  }

  void onUserClicked(User user) async {
    isLoading.value = true;
    await _repository.saveCurrentUserId(user.id ?? "");
    isLoading.value = false;
    navigation.value = Destination(routeName: profileScreenRouteName,argument: user);
  }

  Future<void> blockUser(User user) async {
    isLoading.value = true;
    Result result = await _repository.blockUser(user.id ?? "", !user.isBlocked);
    isLoading.value = false;
    if (result.succeeded()) {
      user.isBlocked = !user.isBlocked;
      notifyListeners();
    }
  }

  void search(String value) {
    if (value.isNotEmpty) {
      filteredUsers = users.where((element) {
        return element.name?.toLowerCase().contains(value) ?? false;
      }).toList();
    } else {
      filteredUsers = [...users];
    }
    notifyListeners();
  }

  void onTypeSelected(User user, UserType? type) {
    user.userType = type;
    selectedUserType = type;
    notifyListeners();
  }

  void updateUserType(User user) async {
    if (user.userType != null) {
      isLoading.value = true;
      Result result =
          await _repository.updateUserType(user.id ?? "", user.userType!);
      isLoading.value = false;
      if (result.succeeded()) {
        successMessage.value = "update_profile_successful_message";
      } else {
        errorMessage.value = "update_profile_error_message";
      }
    }
  }
}
