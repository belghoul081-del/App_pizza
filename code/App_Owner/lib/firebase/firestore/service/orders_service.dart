import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/order/order_Model.dart';

class OrdersFirestoreService {
  final CollectionReference _ordersRef = FirebaseFirestore.instance.collection(
    'orders',
  );

  Stream<List<Order_Model>> streamOrders() {
    return _ordersRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Order_Model.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Future<void> updateOrderStatus(Order_Model order, String newStateKey) async {
    final batch = FirebaseFirestore.instance.batch();
    final orderDoc = _ordersRef.doc(order.orderId);

    batch.update(orderDoc, {'status': newStateKey});

    batch.set(orderDoc.collection('statusHistory').doc(), {
      // ← بدون .doc(newStateKey)
      'status': newStateKey,
      'clientId': order.client.uID,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  /// ✅ جديد: تمييز الطلب كمقروء (تستخدمها شاشة الإشعارات)
  Future<void> markOrderAsRead(String orderId) {
    return _ordersRef.doc(orderId).update({'readByOwner': true});
  }

  Future<void> deleteOrder(String orderId) {
    return _ordersRef.doc(orderId).delete();
  }
}
