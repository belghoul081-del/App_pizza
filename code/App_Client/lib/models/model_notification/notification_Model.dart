class Notification_Model {
  final String title;
  final String image;
  final String description;
  final DateTime createdTime;
  final int price;
  bool isRead;
  Notification_Model({
    required this.title,
    required this.image,
    required this.description,
    required this.createdTime,
    required this.price,
    this.isRead = false,
  });
}

class Notification_Data {
  static List<Notification_Model> notification = [
    Notification_Model(
      title: "Delevery",
      image: "assets/images/categories_images/categories_pizza.png",
      description: """your order has arrived ,
please collect it .""",
      createdTime: DateTime.now(),
      price: 1000,
    ),
    Notification_Model(
      title: "order",
      image: "assets/images/categories_images/categories_pizza.png",
      description: "your order has arrived",
      createdTime: DateTime.now(),
      price: 1000,
    ),
    Notification_Model(
      title: "Delevery",
      image: "assets/images/categories_images/categories_pizza.png",
      description: "your order has arrived",
      createdTime: DateTime.utc(2026, 06, 05, 0),
      price: 1200,
    ),
  ];
}
