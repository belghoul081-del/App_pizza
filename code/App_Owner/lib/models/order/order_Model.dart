import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:app_pizza_owner/models/model_cart/cart_Model.dart';
import 'package:app_pizza_owner/models/order/state_order_Model.dart';

class Order_Model {
  final String orderId;
  final Client_Model client;
  final List<Cart_model> items;
  final int totalOrderPrice;
  // final DateTime orderTime;
  State_Order_Model status;

  Order_Model({
    required this.orderId,
    required this.client,
    required this.items,
    required this.totalOrderPrice,
    //  required this.orderTime,
    required this.status,
  });
}

class order_Data {
  List<Order_Model> order = [
    Order_Model(
      orderId: "1000D293RR",
      client: Client_Model(
        name: "Kader081",
        image: "assets/images/profila_client.png",
      ),
      items: [],
      totalOrderPrice: 1200,
      status: State_Order_Date.state[0], // Pending
    ),
    Order_Model(
      orderId: "ORD-001",
      client: Client_Model(
        name: "عبد القادر",
        image: "assets/images/user1.png",
      ),
      items: [],
      totalOrderPrice: 1500,
      status: State_Order_Date.state[0], // Pending
    ),
    Order_Model(
      orderId: "ORD-002",
      client: Client_Model(name: "محمد", image: "assets/images/user2.png"),
      items: [],
      totalOrderPrice: 2200,
      status: State_Order_Date.state[1], // Preparation
    ),
    Order_Model(
      orderId: "ORD-002",
      client: Client_Model(name: "محمد", image: "assets/images/user2.png"),
      items: [],
      totalOrderPrice: 2200,
      status: State_Order_Date.state[2], // Preparation
    ),

    Order_Model(
      orderId: "ORD-002",
      client: Client_Model(name: "محمد", image: "assets/images/user2.png"),
      items: [],
      totalOrderPrice: 2200,
      status: State_Order_Date.state[3], // Preparation
    ),
  ];
}
