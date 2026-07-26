import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_owner/models/order/order_Model.dart';
import 'package:app_owner/models/order/state_order_Model.dart';
import 'package:app_owner/firebase/firestore/service/orders_service.dart';
import 'package:app_owner/service/notification_service.dart';

class OrderProvider with ChangeNotifier {
  final OrdersFirestoreService _service = OrdersFirestoreService();
  StreamSubscription<List<Order_Model>>? _subscription;

  List<Order_Model> _allOrders = [];
  List<Order_Model> get allOrders => _allOrders;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final Set<String> _knownOrderIds = {};

  OrderProvider() {
    _listenToOrders();
  }

  void _listenToOrders() {
    _subscription = _service.streamOrders().listen(
      (orders) {
        if (_knownOrderIds.isNotEmpty || !_isLoading) {
          for (final order in orders) {
            if (!_knownOrderIds.contains(order.orderId)) {
              NotificationService().show(
                title: "New Order",
                body:
                    "Order from ${order.client.name} worth ${order.totalOrderPrice} Da",
              );
            }
          }
        }

        _knownOrderIds
          ..clear()
          ..addAll(orders.map((o) => o.orderId));

        _allOrders = orders;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = "Failed to fetch orders: $e";
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void refreshNow() {
    _subscription?.cancel();
    _listenToOrders();
  }

  Future<void> advanceOrderStatus(Order_Model order) async {
    final states = State_Order_Date.state;
    final currentIndex = states.indexWhere(
      (s) => s.state == order.status.state,
    );
    if (currentIndex == -1 || currentIndex >= states.length - 1) return;

    final nextState = states[currentIndex + 1];
    await _service.updateOrderStatus(
      order,
      nextState.state,
    ); // was: order.orderId, nextState.state
  }

  Future<void> approveOrder(Order_Model order) async {
    await advanceOrderStatus(order);
  }

  Future<void> rejectOrder(Order_Model order) async {
    await _service.deleteOrder(order.orderId);
  }

  /// ✅ تستخدمها شاشة الإشعارات عند فتح إشعار
  Future<void> markOrderAsRead(String orderId) =>
      _service.markOrderAsRead(orderId);

  Future<void> deleteOrder(String orderId) => _service.deleteOrder(orderId);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
