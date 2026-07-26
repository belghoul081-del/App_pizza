import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityProvider() {
    // مراقبة التغيرات في الاتصال بشكل مستمر وتلقائي
    _subscription = Connectivity().onConnectivityChanged.listen((_) {
      checkInternet();
    });
        checkInternet();

  }

  // دالة للتحقق الفعلي من وجود إنترنت عبر الـ 
  // Ping
 Future<void> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    _isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    _isOnline = false;
  }
  notifyListeners();
}
   @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
