import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';
import 'package:core/model/order_settings.dart';
import 'package:dashboard/domain/model/debt.dart';

import 'firestore_service.dart';

class FireStoreServiceImp implements FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreServiceImp({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  @override
  Future<Result<OrderSettings>> getOrderSettings() async {
    try {
      final settingsCollection = _fireStore.collection('settings');
      final doc = await settingsCollection.get();
      final ridePrice = OrderSettings.fromJson(doc.docs.first.data());
      return Success(ridePrice);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result> updateOrderSettings(OrderSettings settings) async {
    try {
      final settingsCollection = _fireStore.collection('settings');
      final doc = await settingsCollection.get();
      await doc.docs.first.reference.update(settings.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<List<City>>> getCities() async {
    try {
      final citiesCollection = _fireStore.collection('cities');
      final docsRef = await citiesCollection.get();
      var cities =
          docsRef.docs.map((doc) => City.fromJson(doc.data(), doc.id)).toList();
      return Success(cities);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result> addNewCity(City city) async {
    try {
      final citiesCollection = _fireStore.collection('cities');
      citiesCollection.add(city.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result> updateCity(City city) async {
    try {
      final cityDoc = _fireStore.collection('cities').doc(city.id);
      await cityDoc.update(city.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<List<Debt>>> getAllDebts() async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      final debtsDocs = await debtsCollection.get();
      final debts = debtsDocs.docs
          .map((doc) => Debt.fromJson(doc.data(), doc.id))
          .toList();
      return Success(debts);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result> addDebt(Debt debt) async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      debtsCollection.add(debt.toJson());
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result> removeDebt(String? id) async {
    try {
      final debtsCollection = _fireStore.collection('debts');
      await debtsCollection.doc(id).delete();
      return Success(true);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
