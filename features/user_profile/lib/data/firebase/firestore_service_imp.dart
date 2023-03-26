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
  Stream<List<ShopOrder>> getCurrentUserOrders(String userId) {
    final stream = _fireStore
        .collection("orders")
        .where("user._id", isEqualTo: userId)
        .where("orderStatus",
            isNotEqualTo: OrderStatus.delivered.enumToString())
        .snapshots();
    return stream.map((event) =>
        event.docs.map((e) => ShopOrder.fromJson(e.data(), e.id)).toList());
  }

  @override
  Future<List<ShopOrder>> getDeliveredOrdersForUser(String userId) async {
    final response = await _fireStore
        .collection("orders")
        .where("user._id", isEqualTo: userId)
        .where("orderStatus", whereIn: [
      OrderStatus.delivered.enumToString(),
      OrderStatus.done.enumToString(),
    ]).get();
    return response.docs
        .map((doc) => ShopOrder.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Stream<List<ShopOrder>> getAvailableOrdersStream() {
    final stream = _fireStore
        .collection("orders")
        .where("user", isNull: true)
        .snapshots(includeMetadataChanges: true);
    return stream.map((event) =>
        event.docs.map((e) => ShopOrder.fromJson(e.data(), e.id)).toList());
  }

  @override
  Future<Result> addUserToOrders(User user, List<ShopOrder> orders) async {
    final ordersCollection = _fireStore.collection("orders");
    WriteBatch batch = _fireStore.batch();
    for (var order in orders) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await ordersCollection.doc(order.id).get();

      if (docSnapshot.get('user') != null) {
        return Error(ApiException("pick_order_error_body"));
      } else {
        batch.update(
          ordersCollection.doc(order.id),
          {"user": user.toJson()},
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
  Future<void> removeOrders(List<String> ordersId) async {
    final ordersCollection = _fireStore.collection("orders");
    WriteBatch batch = _fireStore.batch();
    for (var id in ordersId) {
      batch.delete(ordersCollection.doc(id));
    }
    await batch.commit();
  }

  @override
  Future<int> getUserCoins(String userId) async {
    final ordersCollection = _fireStore.collection("orders");
    final response = await ordersCollection
        .where("user._id", isEqualTo: userId)
        .where("orderStatus", isEqualTo: OrderStatus.delivered.enumToString())
        .get();
    int? coins = 0;
    for (var doc in response.docs) {
      coins = (coins! + (doc.data()["coins"] ?? 0)) as int?;
    }
    return coins ?? 0;
  }

  @override
  Future<List<ShopOrder>> getAllOrders() async {
    final response = await _fireStore.collection("orders").get();
    return response.docs
        .map((doc) => ShopOrder.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<ShopOrder>> getAvailableOrders() async {
    final orders = await _fireStore
        .collection("orders")
        .where("user", isNull: true)
        .orderBy("time", descending: true)
        .get();
    return orders.docs
        .map((doc) => ShopOrder.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<ShopOrder>> getDeliveredOrders() async {
    final orders = await _fireStore
        .collection("orders")
        .where("orderStatus", isEqualTo: OrderStatus.delivered.enumToString())
        .orderBy("time", descending: true)
        .get();
    return orders.docs
        .map((doc) => ShopOrder.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> updateOrdersStatus(List<String> ordersId) async {
    final ordersCollection = _fireStore.collection("orders");
    WriteBatch batch = _fireStore.batch();
    for (var id in ordersId) {
      batch.update(ordersCollection.doc(id),
          {"orderStatus": OrderStatus.done.enumToString()});
    }
    return await batch.commit();
  }
}
