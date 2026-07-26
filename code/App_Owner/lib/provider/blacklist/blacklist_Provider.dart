import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_owner/models/blacklist/blacklist_Model.dart';
import 'package:app_owner/firebase/firestore/service/blacklist_service.dart';

class BlacklistProvider extends ChangeNotifier {
  final BlacklistFirestoreService _service = BlacklistFirestoreService();
  StreamSubscription<List<Blacklist_Model>>? _subscription;

  List<Blacklist_Model> _blocked = [];
  List<Blacklist_Model> get blocked => _blocked;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  BlacklistProvider() {
    _subscription = _service.streamBlacklist().listen((list) {
      _blocked = list;
      _isLoading = false;
      notifyListeners();
    });
  }

  bool isBlocked(String uID) => _blocked.any((b) => b.uID == uID);

  Future<void> block({
    required String uID,
    required String name,
    required String number,
    required String image,
  }) {
    return _service.blockClient(uID: uID, name: name, number: number, image: image);
  }

  Future<void> unblock(String uID) => _service.unblockClient(uID);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
