import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/blacklist/blacklist_Model.dart';

class BlacklistFirestoreService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'blacklist',
  );

  Stream<List<Blacklist_Model>> streamBlacklist() {
    return _ref.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => Blacklist_Model.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Future<void> blockClient({
    required String uID,
    required String name,
    required String number,
    required String image,
  }) async {
    await _ref
        .doc(uID)
        .set(
          Blacklist_Model(uID: uID, name: name, number: number, image: image).toMap(),
        );
  }

  Future<void> unblockClient(String uID) {
    return _ref.doc(uID).delete();
  }

  Future<bool> isBlocked(String uID) async {
    final doc = await _ref.doc(uID).get();
    return doc.exists;
  }
}
