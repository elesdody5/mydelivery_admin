import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/model/order.dart';
import 'package:core/model/order_status.dart';

import 'firestore_service.dart';

class FireStoreServiceImp implements FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreServiceImp({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  @override
  Stream<List<ShopOrder>> getAvailableShopOrders(String shopId) {
    final stream = _fireStore
        .collection("orders")
        .where("shop._id", isEqualTo: shopId)
        .where('orderStatus', whereNotIn: [
      OrderStatus.delivered.enumToString(),
      OrderStatus.refusedFromShop.enumToString()
    ]).snapshots();
    return stream.map((event) =>
        event.docs.map((e) => ShopOrder.fromJson(e.data(), e.id)).toList());
  }

  @override
  Future<List<ShopOrder>> getDeliveredOrdersForShop(String deliveryId) async {
    final response = await _fireStore
        .collection("orders")
        .where("shop._id", isEqualTo: deliveryId)
        .where("orderStatus", whereIn: [
      OrderStatus.delivered.enumToString(),
      OrderStatus.refusedFromShop.enumToString()
    ]).get();
    return response.docs
        .map((doc) => ShopOrder.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> updateOrderStatus(
      OrderStatus orderStatus, String orderId) async {
    final ordersCollection = _fireStore.collection("orders");
    await ordersCollection
        .doc(orderId)
        .update({"orderStatus": orderStatus.enumToString()});
  }
}
