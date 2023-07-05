/*
* This class responsible for dealing with user data throw the application
* */

import 'dart:convert';

import 'package:core/const.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_manager_interface.dart';

class SharedPreferencesManagerImp implements SharedPreferencesManager {
  SharedPreferencesManagerImp();

  @override
  Future<void> deleteUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<void> saveToken(String? token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (token != null) sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tokenKey);
  }

  @override
  Future<void> saveLocal(String local) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(localKey, local);
  }

  @override
  Future<String> getLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(localKey) ?? "en_US";
  }

  @override
  Future<UserType?> getUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userType = sharedPreferences.getString(userTypeKey);
    return stringToEnum(userType);
  }

  @override
  Future<void> saveUserType(UserType? userType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (userType != null)
      sharedPreferences.setString(userTypeKey, userType.enmToString());
  }

  @override
  Future<String?> getNotificationToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? notificationToken =
        sharedPreferences.getString(notificationTokenKey);
    return notificationToken;
  }

  @override
  Future<void> saveNotificationToken(String? notificationToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    notificationToken?.let((it) =>
        sharedPreferences.setString(notificationTokenKey, notificationToken));
  }

  @override
  Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userIdKey);
  }

  @override
  Future<void> saveUserId(String? userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (userId != null) sharedPreferences.setString(userIdKey, userId);
  }

  @override
  Future<User?> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userDetails = sharedPreferences.getString(userKey);
    if (userDetails == null) return null;
    Map<String, dynamic> userJson = json.decode(userDetails);
    return User.fromJson(userJson);
  }

  @override
  Future<void> saveUserDetails(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> userJson = user.toJson();
    String userDetails = json.encode(userJson);
    sharedPreferences.setString(userKey, userDetails);
  }

  @override
  Future<String?> getVendorShopId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(shopIdKey);
  }

  @override
  Future<void> saveVendorShopId(String shopId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(shopIdKey, shopId);
  }

  @override
  Future<String?> getUserPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(passwordKey);
  }

  @override
  Future<String?> getUserPhone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(phoneKey);
  }

  @override
  Future<void> saveUserPassword(String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(passwordKey, password);
  }

  @override
  Future<void> saveUserPhone(String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(phoneKey, phone);
  }

  @override
  Future<QuickOrder?> getScheduledQuickOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? quickOrderJson = sharedPreferences.getString(quickOrderKey);
    if (quickOrderJson == null) return null;
    sharedPreferences.remove(quickOrderKey);
    return QuickOrder.fromJson(json.decode(quickOrderJson));
  }

  @override
  Future<void> saveScheduleQuickOrder(QuickOrder quickOrder) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var quickOrderJson = await quickOrder.toJson();
    String quickOrderEncoded = json.encode(quickOrderJson);
    sharedPreferences.setString(quickOrderKey, quickOrderEncoded);
  }
}
