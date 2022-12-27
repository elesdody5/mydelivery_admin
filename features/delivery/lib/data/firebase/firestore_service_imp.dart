import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/http_exception.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

import 'firestore_service.dart';

class FireStoreServiceImp implements FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreServiceImp({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Order>> getCurrentDeliveryOrders(String deliveryId) {
    final stream = _fireStore
        .collection("orders")
        .where("delivery._id", isEqualTo: deliveryId)
        .where("orderStatus",
            isNotEqualTo: OrderStatus.delivered.enumToString())
        .snapshots();
    return stream.map((event) =>
        event.docs.map((e) => Order.fromJson(e.data(), e.id)).toList());
  }

  @override
  Future<List<Order>> getDeliveredOrdersForDelivery(String deliveryId) async {
    final response = await _fireStore
        .collection("orders")
        .where("delivery._id", isEqualTo: deliveryId)
        .where("orderStatus", isEqualTo: OrderStatus.delivered.enumToString())
        .get();
    return response.docs
        .map((doc) => Order.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Stream<List<Order>> getAvailableOrders() {
    final stream = _fireStore
        .collection("orders")
        .where("delivery", isNull: true)
        .snapshots(includeMetadataChanges: true);
    return stream.map((event) =>
        event.docs.map((e) => Order.fromJson(e.data(), e.id)).toList());
  }

  @override
  Future<Result> addDeliveryToOrders(User delivery, List<Order> orders) async {
    final ordersCollection = _fireStore.collection("orders");
    WriteBatch batch = _fireStore.batch();
    for (var order in orders) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await ordersCollection.doc(order.id).get();

      if (docSnapshot.get('delivery') != null) {
        return Error(ApiException("pick_order_error_body"));
      } else {
        batch.update(
          ordersCollection.doc(order.id),
          {"delivery": delivery.toJson()},
        );
      }
    }
    await batch.commit();
    return Success(true);
  }

  @override
  Future<void> updateOrderStatus(
      OrderStatus orderStatus, String orderId) async {
    final ordersCollection = _fireStore.collection("orders");
    await ordersCollection
        .doc(orderId)
        .update({"orderStatus": orderStatus.enumToString()});
  }

  @override
  Future<void> removeDeliveryFromOrders(List<String> ordersId) async {
    final ordersCollection = _fireStore.collection("orders");
    WriteBatch batch = _fireStore.batch();
    for (var id in ordersId) {
      batch.update(
        ordersCollection.doc(id),
        {"delivery": null},
      );
    }
    await batch.commit();
  }

  @override
  Future<int> getDeliveryCoins(String deliveryId) async {
    final ordersCollection = _fireStore.collection("orders");
    final response = await ordersCollection
        .where("delivery._id", isEqualTo: deliveryId)
        .where("orderStatus", isEqualTo: OrderStatus.delivered.enumToString())
        .get();
    int? coins = 0;
    for (var doc in response.docs) {
      coins = (coins! + (doc.data()["coins"] ?? 0)) as int?;
    }
    return coins ?? 0;
  }

  @override
  Future<List<Order>> getAllOrders() async {
    final response = await _fireStore.collection("orders").get();
    return response.docs
        .map((doc) => Order.fromJson(doc.data(), doc.id))
        .toList();
  }
}
