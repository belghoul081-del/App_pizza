import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/model_announcement/announcement_Model.dart';
import 'package:app_owner/firebase/storage/storage_service.dart';

/// عروض
class AnnouncementFireStoreService {
  final CollectionReference _announceRef = FirebaseFirestore.instance
      .collection('announce');
  final StorageService _storageService = StorageService();

  /// ستريم لحظي لجلب الإعلانات وتحديثها فوراً
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

  /// إضافة إعلان جديد
  Future<void> addAnnouncement({
    required Announcement_Model
    announcement,
    required File imageFile,
  }) async {
    final imageUrl = await _storageService.uploadannounceImage(
      announceId: announcement.id,
      imageFile: imageFile,
    );

    final data = announcement.toMap();
    data['imagePath'] = imageUrl;

    await _announceRef.doc(announcement.id).set(data);
  }

  /// تحديث إعلان موجود
  Future<void> updateAnnouncement(
    Announcement_Model announcement, {
    File? newImageFile,
  }) async {
    String imagePath = announcement.imagePath;
    if (newImageFile != null) {
      imagePath = await _storageService.uploadannounceImage(
        announceId: announcement.id,
        imageFile: newImageFile,
      );
    }

    final data = announcement.toMap();
    data['imagePath'] = imagePath;

    await _announceRef.doc(announcement.id).update(data);
  }

  /// حذف الإعلان
  Future<void> deleteAnnouncement(String id) async {
    await _announceRef.doc(id).delete();
  }
}
