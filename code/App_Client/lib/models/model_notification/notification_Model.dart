import 'package:app_pizza_client/models/order/order_Model.dart';

class Notification_Model {
  final String orderId;
  final String title;
  final String status;
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
    required this.status,
    required this.description,
    required this.createdTime,
    required this.price,
    required this.isRead,
    required this.order,
  });

  static Notification_Model? fromHistory({
    required String status,
    required DateTime? createdAt,
    required Order_Model order,
    bool isRead = false,
  }) {
    String title = "";
    String description = "";
    const String image = "assets/images/login_images/logo_pizza.png";

    switch (status) {
      case "Cook":
        title = "Prepared 🍳";
        description = "Your order has been prepared";
        break;
      case "Delivery":
        title = "On the Way 🛵";
        description = "Your order is out for delivery and on its way to you.";
        break;
      case "Finish":
        title = "Order Completed 🍔";
        description =
            "Your order has been successfully delivered. Enjoy your meal!";
        break;
      default:
        return null;
    }

    return Notification_Model(
      orderId: order.orderId,
      title: title,
      image: image,
      status: status,
      description: description,
      createdTime: createdAt,
      price: order.totalOrderPrice,
      isRead: isRead,
      order: order,
    );
  }
}
