import 'package:core/base_provider.dart';
import 'package:core/domain/city.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/domain/address.dart' as address;
import 'package:core/model/shop.dart';
import 'package:quickorder/domain/model/PhoneContact.dart';

import '../data/repository/repository.dart';
import '../data/repository/repository_imp.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class QuickOrderFormProvider extends BaseProvider {
  final Repository _repository;
  QuickOrder quickOrder = QuickOrder(address: address.Address());
  User? user;
  List<Shop> shops = [];
  List<PhoneContact> phoneContacts = [];
  List<City> cities = [];
  bool showCities = false;

  City? selectedCity;

  QuickOrderFormProvider({Repository? repository})
      : _repository = repository ?? QuickOrderRepository();

  Future<void> sendQuickOrder() async {
    isLoading.value = true;
    Result result;
    if (quickOrder.id != null) {
      result = await _repository.updateQuickOrder(quickOrder);
    } else {
      result = await addQuickOrder();
    }
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "quick_order_successfully";
    } else {
      errorMessage.value = "something_went_wrong";
    }
    quickOrder = QuickOrder();
  }

  void toggleCitiesVisibility(bool showCities) {
    this.showCities = showCities;
    notifyListeners();
  }

  Future<Result> addQuickOrder() async {
    quickOrder.dateTime = DateTime.now();
    return await _repository.sendQuickOrder(quickOrder);
  }

  Future<void> init(QuickOrder? quickOrder) async {
    setInitQuickOrder(quickOrder);
    await Future.wait([getShops(), getContacts(), getCities()]);
    notifyListeners();
  }

  Future<void> getShops() async {
    Result result = await _repository.getAllShops();
    if (result.succeeded()) {
      shops = result.getDataIfSuccess();
    }
  }

  Future<void> getCities() async {
    Result result = await _repository.getCities();
    if (result.succeeded()) {
      cities = result.getDataIfSuccess();
    }
  }

  Future<void> getContacts() async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      phoneContacts =
          contacts.where((element) => element.phones.isNotEmpty).map((contact) {
        String number = contact.phones.first.number;
        number = number.replaceAll("+", "");

        if (_hasWitheSpaces(number)) {
          number = _reverseNumber(number);
        }
        if (_hasDashes(number)) {
          number = _removeDashes(number);
        }
        if (_startWith(number)) {
          number = _removeFirstNumber(number);
        }
        return PhoneContact(name: contact.displayName, number: number);
      }).toList();
    }
  }

  bool _hasWitheSpaces(String number) => number.trim().contains(" ");

  bool _startWith(String number) => number.trim().indexOf("2") == 0;

  bool _hasDashes(String number) => number.trim().contains("-");

  String _removeDashes(String number) => number.replaceAll("-", "");

  String _removeFirstNumber(String number) => number.replaceFirst("2", "");

  String _reverseNumber(String number) {
    List<String> numbers = number.split(" ");
    return numbers.join("");
  }

  void setInitQuickOrder(QuickOrder? quickOrder) {
    if (quickOrder != null) {
      this.quickOrder = quickOrder;
    }
  }

  Future<void> scheduleQuickOrder(Duration duration) async {
    quickOrder.dateTime = DateTime.now().add(duration);
    await _repository.scheduleQuickOrder(duration, quickOrder);
    successMessage.value = "quick_order_successfully";
  }
}
