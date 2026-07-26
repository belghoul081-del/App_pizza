import 'package:app_pizza_client/models/order/location_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/order/order_Model.dart';

/// تطبيق العميل "ينشئ" الطلب فقط،و يحذفه  ولا يقرأه أو يعدّل حالته - ذلك من صلاحيات

class OrdersFirestoreService {
  final CollectionReference _ordersRef = FirebaseFirestore.instance.collection(
    'orders',
  );

  Future<String> submitOrder({
    required String clientName,
    required String clientNumber,
    required String clientImage,
    required String clientId,
    required List<Cart_model> items,
    required int totalPrice,
    Location_Model? location,
  }) async {
    final orderRef = _ordersRef.doc();

    await orderRef.set({
      'client': {
        'name': clientName,
        'number': clientNumber,
        'image': clientImage,
        'uID': clientId,
      },
      'items': items
          .map(
            (c) => {
              'productId': c.product.id,
              'name': c.product.name,
              'imagePath': c.product.imagePath,
              'price': c.pricePerUnit,
              'quantity': c.quantity,
              'supplements': c.sepliment
                  .map((s) => {'name': s.name, 'price': s.price})
                  .toList(),
            },
          )
          .toList(),
      'totalOrderPrice': totalPrice,
      'status': 'waiting',
      'location': location != null && location.isSet ? location.toMap() : null,
      'readByOwner': false,
      'readByClient': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return orderRef.id;
  }

  Stream<List<Order_Model>> streamMyOrders(String uid) {
    return _ordersRef
        .where('client.uID', isEqualTo: uid)
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

  Stream<List<Map<String, dynamic>>> streamMyStatusHistory(String uid) {
    return FirebaseFirestore.instance
        .collectionGroup('statusHistory')
        .where('clientId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) {
            final data = d.data();
            return {
              'orderId': d.reference.parent.parent!.id,
              'status': data['status'] as String,
              'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
            };
          }).toList(),
        );
  }

  /// ✅  تحديث حالة القراءة للزبون
  Future<void> markOrderAsRead(String orderId) async {
    await _ordersRef.doc(orderId).update({'readByClient': true});
  }

  Future<void> deleteOrder(String orderId) async {
    await _ordersRef.doc(orderId).delete();
  }
}
