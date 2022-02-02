import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/domain/result.dart';
import 'package:dashboard/domain/model/order_settings.dart';

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
}
