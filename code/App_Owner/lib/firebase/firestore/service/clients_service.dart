import 'package:cloud_firestore/cloud_firestore.dart';

/// ✅ جديد: خدمة جلب كل بيانات المستخدمين (الزبائن) من مجموعة "clients"
/// دفعة واحدة، لاستخدامها في تطبيق المالك (مثلاً لعرض/تحليل الزبائن).
class ClientsFirestoreService {
  final CollectionReference _clientsRef = FirebaseFirestore.instance
      .collection('clients');

  Future<List<Map<String, dynamic>>> getAllClients() async {
    final snapshot = await _clientsRef.get();
    return snapshot.docs
        .map((doc) => {...doc.data() as Map<String, dynamic>, 'uID': doc.id})
        .toList();
  }
}
