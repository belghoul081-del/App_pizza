import 'package:app_pizza_client/models/admin/ownerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFirestoreService {
  final CollectionReference _adminRef = FirebaseFirestore.instance.collection(
    'adminInf',
  );

  /// ستريم لحظي لأول (والوحيد) مستند في المجموعة، حتى ينعكس تغيير حالة
  /// المتجر (مفتوح/مغلق) فورًا عند الزبون.
  Stream<Admin_Model> streamAdmin() {
    return _adminRef.limit(1).snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) return Admin_Model();
      return Admin_Model.fromMap(
        snapshot.docs.first.data() as Map<String, dynamic>,
      );
    });
  }
}