import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/city.dart';

import 'firestore_service.dart';

class FireStoreServiceImp implements FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreServiceImp({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

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



}
