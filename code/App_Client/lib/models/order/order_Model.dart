import 'package:app_pizza_client/models/order/location_Model.dart';
import 'package:app_pizza_client/models/order/order_item_Model.dart';
import 'package:app_pizza_client/models/order/state_order_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// نسخة القراءة فقط لتطبيق العميل: يعرض فقط طلباته الخاصة 
class Order_Model {
  final String orderId;
  final int totalOrderPrice;
  final DateTime? createdAt;
  final Location_Model location; 
  final List<OrderItem_Model> items;
  final State_Order_Model status;
  final bool isRead;

  Order_Model({
    required this.orderId,
    required this.totalOrderPrice,
    required this.status,
    this.createdAt,
    required this.location,
    this.items = const [],
    this.isRead = false,
  });
 bool get isActive =>
      status.state != State_Order_Date.state.last.state &&
      status.state != State_Order_Date.cancelled.state;

  factory Order_Model.fromMap(String id, Map<String, dynamic> map) {
    final String statusKey =
        map['status'] ?? State_Order_Date.state.first.state;
   final State_Order_Model matchedStatus =
        statusKey == State_Order_Date.cancelled.state
        ? State_Order_Date.cancelled
        : State_Order_Date.state.firstWhere(
            (s) => s.state == statusKey,
            orElse: () => State_Order_Date.state.first,
          );
    final rawItems = (map['items'] as List?) ?? [];

    return Order_Model(
      orderId: id,
      totalOrderPrice: (map['totalOrderPrice'] as num?)?.toInt() ?? 0,
      status: matchedStatus,
      location: Location_Model.fromMap(map['location'] as Map<String, dynamic>?),
      items: rawItems
          .map((e) => OrderItem_Model.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
          isRead: map['readByClient'] as bool? ?? false,
    );
  }
  Order_Model copyWith({bool? isRead}) {
    return Order_Model(
      orderId: orderId,
      totalOrderPrice: totalOrderPrice,
      status: status,
      createdAt: createdAt,
      location: location,
      items: items,
      isRead: isRead ?? this.isRead,
    );
  }
}
