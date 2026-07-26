import 'package:cloud_firestore/cloud_firestore.dart';

class BlacklistFirestoreService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'blacklist',
  );

  Stream<bool> streamIsBlocked(String uID) {
    return _ref.doc(uID).snapshots().map((doc) => doc.exists);
  }

  Future<bool> isBlocked(String uID) async {
    final doc = await _ref.doc(uID).get();
    return doc.exists;
  }
}