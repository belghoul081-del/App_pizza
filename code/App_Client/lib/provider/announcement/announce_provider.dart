
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/firebase/firestore/service/announce_service.dart';
import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';

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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
