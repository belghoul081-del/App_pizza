import 'package:app_owner/models/order/order_Model.dart';

class Notification_Model {
  final String orderId;
  final String title;
  final String image;
  final String description;
  final DateTime? createdTime;
  final int price;
  final bool isRead;
  final Order_Model order;

  Notification_Model({
    required this.orderId,
    required this.title,
    required this.image,
    required this.description,
    required this.createdTime,
    required this.price,
    required this.isRead,
    required this.order,
  });

  factory Notification_Model.fromOrder(Order_Model order) {
    return Notification_Model(
      orderId: order.orderId,
      title: "new order",
      image: order.client.image,
      description:
          "new order ${order.client.name} At cost ${order.totalOrderPrice} Da",
      createdTime: order.createdAt,
      price: order.totalOrderPrice,
      isRead: order.readByOwner,
      order: order,
    );
  }
}
