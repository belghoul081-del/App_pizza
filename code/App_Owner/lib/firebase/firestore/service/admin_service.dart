import 'package:cloud_firestore/cloud_firestore.dart';


class AdminFirestoreService {
  final CollectionReference _adminRef = FirebaseFirestore.instance.collection(
    'adminInf',
  );

  Future<void> updateAdminName(String newName) async {
    final snapshot = await _adminRef.limit(1).get();
    if (snapshot.docs.isEmpty) return;
    await snapshot.docs.first.reference.update({'name': newName});
  }
  /// open / close : store
  Future<void> updateStoreStatus(bool isOpen) async {
    final snapshot = await _adminRef.limit(1).get();
    if (snapshot.docs.isEmpty) return;
    await snapshot.docs.first.reference.update({'isOpen': isOpen});
  }
   Future<void> updateAdminNumbers({
    required String number,
    required String number2,
  }) async {
    final snapshot = await _adminRef.limit(1).get();
    if (snapshot.docs.isEmpty) return;
    await snapshot.docs.first.reference.update({
      'number': number,
      'number2': number2,
    });
  }

}
