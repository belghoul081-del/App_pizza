import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference adminInf = FirebaseFirestore.instance.collection(
    "adminInf",
  );

  /// Admin Inf:
  Future<List<Map<String, dynamic>>> GetAdminInf() async {
    QuerySnapshot querySnapshot = await adminInf.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
