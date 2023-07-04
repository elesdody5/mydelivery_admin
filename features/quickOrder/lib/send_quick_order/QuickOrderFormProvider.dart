import 'package:core/base_provider.dart';
import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/shop.dart';
import 'package:quickorder/domain/model/PhoneContact.dart';

import '../data/repository/repository.dart';
import '../data/repository/repository_imp.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class QuickOrderFormProvider extends BaseProvider {
  final Repository _repository;
  QuickOrder quickOrder = QuickOrder();
  User? user;
  List<Shop> shops = [];
  List<PhoneContact> phoneContacts = [];

  QuickOrderFormProvider({Repository? repository})
      : _repository = repository ?? MainRepository();

  Future<void> sendQuickOrder() async {
    isLoading.value = true;
    quickOrder.dateTime = DateTime.now();
    Result result = await _repository.sendQuickOrder(quickOrder);
    isLoading.value = false;
    if (result.succeeded()) {
      successMessage.value = "quick_order_successfully";
    } else {
      errorMessage.value = "something_went_wrong";
    }
    quickOrder = QuickOrder();
  }

  Future<void> init() async {
    await Future.wait([getShops(), getContacts()]);
  }

  Future<void> getShops() async {
    Result result = await _repository.getAllShops();
    if (result.succeeded()) {
      shops = result.getDataIfSuccess();
      notifyListeners();
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
      notifyListeners();
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
}
