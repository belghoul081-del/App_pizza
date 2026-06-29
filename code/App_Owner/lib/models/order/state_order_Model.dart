class State_Order_Model {
  final String name;
  final String imagePath;
  final String state;
  State_Order_Model({
    required this.name,
    required this.imagePath,
    required this.state,
  });
}

class State_Order_Date {
  static List<State_Order_Model> state = [
    State_Order_Model(name: "Pending", imagePath: "assets/icons/order/Icon_box.svg", state: "waiting"),
    State_Order_Model(name: "Preparation", imagePath: "assets/icons/order/Icon_cook.svg", state: "Cook"),
    State_Order_Model(name: "Progress", imagePath: "assets/icons/order/Icon_delivery.svg", state: "Delivery"),
    State_Order_Model(name: "Finish", imagePath: "assets/icons/order/Icon_pizza.svg", state: "Finish")
  ];
}
