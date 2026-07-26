
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';

class AnnouncementFireStoreService {
  final CollectionReference _announceRef = FirebaseFirestore.instance
      .collection('announce');

  Stream<List<Announcement_Model>> streamAnnouncement() {
    return _announceRef.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => Announcement_Model.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
