import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/firebase/firestore/service/blacklist_service.dart';

/// يراقب حالة حظر الزبون الحالي لحظيًا طوال بقاء التطبيق مفتوحًا (وليس فقط
class BlacklistProvider extends ChangeNotifier {
  final BlacklistFirestoreService _service = BlacklistFirestoreService();
  StreamSubscription<bool>? _subscription;
  StreamSubscription<User?>? _authSubscription;

  bool _isBlocked = false;
  bool get isBlocked => _isBlocked;

  BlacklistProvider() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) {
      _subscription?.cancel();
      _isBlocked = false;

      if (user != null) {
        _subscription = _service.streamIsBlocked(user.uid).listen((blocked) {
          _isBlocked = blocked;
          notifyListeners();
        });
      } else {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}