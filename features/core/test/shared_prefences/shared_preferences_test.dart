import 'package:core/data/shared_preferences/shared_preferences_manager.dart';
import 'package:core/data/shared_preferences/user_manager_interface.dart';
import 'package:core/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  late SharedPreferencesManager sharedPreferenceManager;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    sharedPreferenceManager = SharedPreferencesManagerImp();
  });
  test("save user details", () async {
    User user = User(id: "1", name: "Ahmed");
    await sharedPreferenceManager.saveUserDetails(user);
    User? expectedUser = await sharedPreferenceManager.getUserDetails();
    expect(expectedUser, user);
  });
}
