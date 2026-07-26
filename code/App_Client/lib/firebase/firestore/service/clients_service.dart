import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';

/// يخزّن/يجلب ملف الزبون في Firestore. معرّف المستند = نفس UID الخاص
class ClientsFirestoreService {
  final CollectionReference _clientsRef = FirebaseFirestore.instance
      .collection('clients');

  Future<void> createClientProfile(String uid, Client_Model client) {
    return _clientsRef.doc(uid).set(client.toMap(uid));
  }

  Future<Client_Model?> getClientProfile(String uid) async {
    final doc = await _clientsRef.doc(uid).get();
    if (!doc.exists) return null;
    return Client_Model.fromMap(doc.data() as Map<String, dynamic>);
  }
  Future<void> updateClientImage(String uid, String imageUrl) {
    return _clientsRef.doc(uid).update({'image': imageUrl});
  }
   /// ✅ جديد: تحديث اسم الزبون فقط (تستخدمها صفحة الإعدادات)
  Future<void> updateClientName(String uid, String name) {
    return _clientsRef.doc(uid).update({'name': name});
  }
}
