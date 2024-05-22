import 'package:core/base_provider.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'data/repository/user_repository.dart';
import 'data/repository/user_repository_imp.dart';

class ProfileProvider extends BaseProvider {
  User? user;
  final UserRepository _repository;

  ProfileProvider({UserRepository? repository})
      : _repository = repository ?? UserRepositoryImp();

  void decreaseScore() {
    if (user?.coins != null && user!.coins! > 0) {
      user?.coins = user!.coins! - 1;
      notifyListeners();
    }
  }

  void increaseScore() {
    user?.coins = (user?.coins ?? 0) + 1;
    notifyListeners();
  }

  Future<void> updateUser() async {
    if (user != null) {
      isLoading.value = true;
      Result result = await _repository.updateUser(user!);
      isLoading.value = false;
      if (result.succeeded()) {
        successMessage.value = "update_profile_successful_message";
      } else {
        errorMessage.value = result.getErrorMessage();
      }
    }
  }

  Future<void> getUserDetails(User? user) async {
    if (user != null) {
      this.user = user;
    } else {
      Result<User> result = await _repository.getUserDetails();
      if (result.succeeded()) {
        user = result.getDataIfSuccess();
      }
    }
    notifyListeners();
  }
}
