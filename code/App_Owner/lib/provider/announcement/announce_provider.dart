import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_owner/firebase/firestore/service/announce_service.dart';
import 'package:app_owner/models/model_announcement/announcement_Model.dart';

class AnnouncementProvider extends ChangeNotifier {
  final AnnouncementFireStoreService _service = AnnouncementFireStoreService();
  StreamSubscription<List<Announcement_Model>>? _subscription;

  List<Announcement_Model> _announcement = [];
  List<Announcement_Model> get announcement => _announcement;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  AnnouncementProvider() {
    _listenToAnnouncement();
  }

  void _listenToAnnouncement() {
    _subscription = _service.streamAnnouncement().listen(
      (announcementsList) {
        _announcement = announcementsList;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = "announce err $e";
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// إضافة إعلان جديد (يرفع الصورة إلى Storage ثم يكتب المستند في Firestore).
  Future<void> addAnnouncement(
    Announcement_Model announcement,
    File imageFile,
  ) async {
    await _service.addAnnouncement(
      announcement: announcement,
      imageFile: imageFile,
    );
  }

  /// تحديث إعلان موجود
  Future<void> updateAnnouncement(
    Announcement_Model announcement, {
    File? newImageFile,
  }) async {
    await _service.updateAnnouncement(announcement, newImageFile: newImageFile);
  }

  /// حذف الإعلان
  Future<void> removeAnnouncement(String announcementId) async {
    await _service.deleteAnnouncement(announcementId);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
