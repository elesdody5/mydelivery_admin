import 'package:core/base_provider.dart';
import 'package:core/domain/PhoneContact.dart';
import 'package:core/domain/result.dart';
import 'package:debts/domain/debts_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../data/debts_repository_imp.dart';
import '../domain/model/debt.dart';

class DebtsProvider extends BaseProvider {
  List<Debt> _debts = [];
  List<Debt> filteredDebts = [];
  final DebtsRepository _repository;

  DebtsProvider({DebtsRepository? repository})
      : _repository = repository ?? DebtsRepositoryImp();

  Future<void> getAllDebts() async {
    Result<List<Debt>> result = await _repository.getAllDebts();
    if (result.succeeded()) {
      _debts = result.getDataIfSuccess();
      filteredDebts = [..._debts];
      notifyListeners();
    }
  }

  Future<void> addDebt(Debt debt) async {
    isLoading.value = true;
    Result<String> result = await _repository.addDebts(debt);
    isLoading.value = false;
    if (result.succeeded()) {
      debt.id = result.getDataIfSuccess();
      _debts.add(debt);
      filteredDebts = [..._debts];
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }

  Future<void> removeDebt(Debt debt) async {
    isLoading.value = true;
    Result result = await _repository.removeDebt(debt.id);
    isLoading.value = false;
    if (result.succeeded()) {
      _debts.remove(debt);
      filteredDebts = [..._debts];
      notifyListeners();
    } else {
      errorMessage.value = "something_went_wrong";
    }
  }

  void updateDebt(Debt? debt) {
    if (debt != null) {
      int index = _debts.indexWhere((element) => element.id == debt.id);
      if (index != -1) {
        _debts[index] = debt;
        filteredDebts = [..._debts];
      }
      notifyListeners();
    }
  }

  void search(String debtTitle) {
    if (debtTitle.isNotEmpty) {
      filteredDebts = _debts.where((element) {
        return element.title?.toLowerCase().contains(debtTitle) ?? false;
      }).toList();
    } else {
      filteredDebts = [..._debts];
    }
    notifyListeners();
  }

  Future<List<PhoneContact>> getPhoneContacts() async {
    List<PhoneContact> phoneContacts = [];
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      isLoading.value = true;
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
    isLoading.value = false;
    return phoneContacts;
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
