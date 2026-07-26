import 'dart:async';
import 'package:app_pizza_client/models/admin/ownerModel.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/firebase/firestore/service/admin_service.dart';

/// يراقب بيانات المالك (اسم/صورة/رقم المطعم + هل المتجر مفتوح isOpen)
class AdminProvider extends ChangeNotifier {
  final AdminFirestoreService _service = AdminFirestoreService();
  StreamSubscription<Admin_Model>? _subscription;

  Admin_Model _admin = Admin_Model();
  Admin_Model get admin => _admin;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool get isOpen => _admin.isOpen;

  AdminProvider() {
    _subscription = _service.streamAdmin().listen(
      (admin) {
        _admin = admin;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
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
