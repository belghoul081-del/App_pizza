import 'package:app_owner/models/client/client_Model.dart';
import 'package:app_owner/models/order/order_item_Model.dart';
import 'package:app_owner/models/order/state_order_Model.dart';
import 'package:app_owner/models/order/location_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order_Model {
  final String orderId;
  final Client_Model client;
  final List<OrderItem_Model> items;
  final int totalOrderPrice;
  final DateTime? createdAt;
  final Location_Model location;
  final bool readByOwner;
  State_Order_Model status;

  Order_Model({
    required this.orderId,
    required this.client,
    required this.items,
    required this.totalOrderPrice,
    required this.status,
    this.createdAt,
    required this.location,
    this.readByOwner = false,
  });

  factory Order_Model.fromMap(String id, Map<String, dynamic> map) {
    final String statusKey = map['status'] ?? State_Order_Date.state.first.state;
    final State_Order_Model matchedStatus = statusKey == State_Order_Date.cancelled.state
        ? State_Order_Date.cancelled
        : State_Order_Date.state.firstWhere(
            (s) => s.state == statusKey,
            orElse: () => State_Order_Date.state.first,
          );
    final rawItems = (map['items'] as List?) ?? [];


    return Order_Model(
      orderId: id,
      client: Client_Model.fromMap(Map<String, dynamic>.from(map['client'] ?? {})),
      items: rawItems
          .map((e) => OrderItem_Model.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      totalOrderPrice: (map['totalOrderPrice'] as num?)?.toInt() ?? 0,
      status: matchedStatus,
      location: Location_Model.fromMap(map['location'] as Map<String, dynamic>?),
      readByOwner: map['readByOwner'] == true,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}
