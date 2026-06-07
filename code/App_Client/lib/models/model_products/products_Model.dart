class Products_model {
  final int id;
  final String name;
  final int price;
   final String imagePath;
  final String categories;
  // final bool isAvailable;
  // final suplint;
  Products_model({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    // required this.isAvailable,

       required this.imagePath,
  });
}

class Products_Data {
  static List<Products_model> cards_of_Products = [


    Products_model(id: 2, name: "pizza", price: 500, categories: '##-pizza', imagePath: 'assets/images/product_imags/pizza/pizza_pipirony.png'),
   
  ];
}
