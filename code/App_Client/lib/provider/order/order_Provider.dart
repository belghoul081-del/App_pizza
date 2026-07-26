import 'dart:async';
import 'package:app_pizza_client/firebase/firestore/service/orders_service.dart';
import 'package:app_pizza_client/models/model_notification/notification_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/models/order/order_Model.dart';
import 'package:app_pizza_client/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  final OrdersFirestoreService _service = OrdersFirestoreService();
  StreamSubscription<List<Order_Model>>? _subscription;
  StreamSubscription<List<Map<String, dynamic>>>? _historySubscription;
  StreamSubscription<User?>? _authSubscription;

  Set<String> _readNotificationKeys = {};
  List<Order_Model> _myOrders = [];
  List<Order_Model> get myOrders => _myOrders;

  List<Notification_Model> _notifications = [];
  List<Notification_Model> get notifications => _notifications;

  Order_Model? _recentlyFinishedOrder;
  Timer? _finishGraceTimer;
  static const Duration _finishGracePeriod = Duration(minutes: 2);

  bool get hasUnreadNotification =>
      _notifications.any((notification) => !notification.isRead);
  bool get hasActiveOrder =>
      _myOrders.any((order) => order.isActive) ||
      _recentlyFinishedOrder != null;

  Order_Model? get activeOrder {
    for (final order in _myOrders) {
      if (order.isActive) return order;
    }
    return _recentlyFinishedOrder;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Map<String, dynamic>> _latestHistory = [];
  DateTime? _lastNotifiedTime;
  bool _isFirstHistoryLoad = true;

  String? _currentUid;
  OrderProvider() {
    // ✅ يبدأ/يوقف المراقبة تلقائيًا مع تسجيل الدخول/الخروج، بدل الاعتماد
    // على استدعاء يدوي من الشاشات.
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) async {
      if (user?.uid == _currentUid) return;
      _currentUid = user?.uid;

      _subscription?.cancel();
      _historySubscription?.cancel();
      _finishGraceTimer?.cancel();
      _recentlyFinishedOrder = null;
      _myOrders = [];
      _notifications = [];
      _latestHistory = [];
      _lastNotifiedTime = null;
      _isFirstHistoryLoad = true;

      if (user != null) {
        await _loadReadKeys(user.uid);
        _listen(user.uid);
      } else {
        notifyListeners();
      }
    });
  }

  void _listen(String uid) {
    _isLoading = true;
    notifyListeners();

    _subscription = _service
        .streamMyOrders(uid)
        .listen(
          (orders) {
            Order_Model? previousActive;
            for (final o in _myOrders) {
              if (o.isActive) {
                previousActive = o;
                break;
              }
            }
            _myOrders = orders;
            _isLoading = false;

            if (previousActive != null) {
              final stillActive = orders.any(
                (o) => o.orderId == previousActive!.orderId && o.isActive,
              );
              if (!stillActive) {
                final updatedMatches = orders
                    .where((o) => o.orderId == previousActive!.orderId)
                    .toList();

                if (updatedMatches.isNotEmpty) {
                  _recentlyFinishedOrder = updatedMatches.first;
                  _finishGraceTimer?.cancel();
                  _finishGraceTimer = Timer(_finishGracePeriod, () {
                    _recentlyFinishedOrder = null;
                    notifyListeners();
                  });
                } else {
                  _finishGraceTimer?.cancel();
                  _recentlyFinishedOrder = null;
                }
              }
            }

            _rebuildNotifications();
            notifyListeners();
          },
          onError: (e) {
            debugPrint('❌ streamMyorder error: $e');
            _isLoading = false;
            notifyListeners();
          },
        );

    _historySubscription = _service
        .streamMyStatusHistory(uid)
        .listen(
          (history) {
            _latestHistory = history;

            if (_isFirstHistoryLoad) {
              _lastNotifiedTime = history.isNotEmpty
                  ? history.first['createdAt'] as DateTime?
                  : null;
              _isFirstHistoryLoad = false;
            } else if (history.isNotEmpty) {
              final newest = history.first;
              final newestTime = newest['createdAt'] as DateTime?;
              if (newestTime != null &&
                  (_lastNotifiedTime == null ||
                      newestTime.isAfter(_lastNotifiedTime!))) {
                _lastNotifiedTime = newestTime;
                final matchingOrder = _myOrders
                    .where((o) => o.orderId == newest['orderId'])
                    .toList();
                if (matchingOrder.isNotEmpty) {
                  final notif = Notification_Model.fromHistory(
                    status: newest['status'] as String,
                    createdAt: newestTime,
                    order: matchingOrder.first,
                  );
                  if (notif != null) {
                    NotificationService().show(
                      title: notif.title,
                      body: notif.description,
                    );
                  }
                }
              }
            }

            _rebuildNotifications();
            notifyListeners();
          },
          onError: (e) {
            debugPrint('❌ streamMyStatusHistory error: $e');
            _error = "Failed to load notifications";
            notifyListeners();
          },
        );
  }

  String _prefsKey(String uid) => 'read_notifications_$uid';

  Future<void> _loadReadKeys(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    _readNotificationKeys = (prefs.getStringList(_prefsKey(uid)) ?? []).toSet();
  }

  Future<void> markNotificationAsRead(String orderId, String status) async {
    final key = '$orderId:$status';
    if (_readNotificationKeys.contains(key)) return;

    _readNotificationKeys.add(key);
    _rebuildNotifications();
    notifyListeners();

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey(uid), _readNotificationKeys.toList());
  }

  void _rebuildNotifications() {
    // نجمع الطلبات التي وصلت فعلاً لحالة "تم الوصول"
    final finishedOrderIds = _latestHistory
        .where((entry) => entry['status'] == 'Finish')
        .map((entry) => entry['orderId'] as String)
        .toSet();

    final List<Notification_Model> result = [];
    for (final entry in _latestHistory) {
      final orderId = entry['orderId'] as String;
      final status = entry['status'] as String;

      // إذا كان الطلب قد انتهى، تجاهل إشعاري التحضير والتوصيل الخاصين به
      if (finishedOrderIds.contains(orderId) &&
          (status == 'Cook' || status == 'Delivery')) {
        continue;
      }

      final matches = _myOrders.where((o) => o.orderId == orderId).toList();
      if (matches.isEmpty) continue;

      final key = '$orderId:$status';
      final notif = Notification_Model.fromHistory(
        status: status,
        createdAt: entry['createdAt'] as DateTime?,
        order: matches.first,
        isRead: _readNotificationKeys.contains(key),
      );
      if (notif != null) result.add(notif);
    }

    result.sort((a, b) {
      final aTime = a.createdTime;
      final bTime = b.createdTime;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return bTime.compareTo(aTime);
    });
    _notifications = result;
  }

  void refreshNow() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    _subscription?.cancel();
    _historySubscription?.cancel();
    _listen(uid);
  }

  // Inside OrderProvider
  Future<void> markOrderAsRead(String orderId) async {
    try {
      await _service.markOrderAsRead(orderId); // firestore update
      // Update local state optimistically
      final index = _myOrders.indexWhere((o) => o.orderId == orderId);
      if (index != -1) {
        _myOrders[index] = _myOrders[index].copyWith(isRead: true);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error marking as read: $e');
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    Order_Model? order;
    for (final o in _myOrders) {
      if (o.orderId == orderId) {
        order = o;
        break;
      }
    }
    if (order == null) return false;

    if (order.status.state != 'waiting') {
      // الطلب تم قبوله بالفعل من طرف المالك، لا يمكن حذفه
      return false;
    }

    try {
      await _service.deleteOrder(orderId);
      _myOrders.removeWhere((o) => o.orderId == orderId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting order: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _historySubscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
