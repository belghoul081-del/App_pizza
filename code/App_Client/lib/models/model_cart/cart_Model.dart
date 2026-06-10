class Cart_model {
  final String name;
  final int price;
  final String imagePath;
  int quqntity;
  Cart_model({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quqntity =1
  });
}

class Cart_Data {
  static List<Cart_model> cart_of_Products = [
    // --- PIZZA ---
    Cart_model(
      name: "Pizza 4 Fromage",
      price: 600,
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
    ),
    Cart_model(
      name: "Pizza Vegitaria",
      price: 550,
      imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
    ),
    Cart_model(
      name: "Coca Cola 33cl",
      price: 150,
      imagePath: 'assets/images/prodect_images/jues/canet_cocacola.png',
    ),
  ];
}
