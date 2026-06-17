class Products_model {
  final int id;
  final String name;
  final int price;
  final String imagePath;
  final String categories;
  // final bool isAvailable;
  bool favorit;
  // final suplint;

  void toggleFavorite() {
    favorit = !favorit;
  }

  Products_model({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    this.favorit = false,
    // required this.isAvailable,
    required this.imagePath,
  });
}

class Products_Data {
  static List<Products_model> cards_of_Products = [
    // --- PIZZA ---
    Products_model(
      id: 1,
      name: "Pizza 4 Fromage",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
    ),
    Products_model(
      id: 2,
      name: "Pizza Vegitaria",
      price: 550,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
    ),
    Products_model(
      id: 3,
      name: "Pizza Viande",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Viande.png',
    ),
    Products_model(
      id: 1,
      name: "Pizza 4 Fromage",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
    ),
    Products_model(
      id: 2,
      name: "Pizza Vegitaria",
      price: 550,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
    ),
    Products_model(
      id: 3,
      name: "Pizza Viande",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Viande.png',
    ),

    // --- BURGER ---
    Products_model(
      id: 4,
      name: "Classic Burger",
      price: 450,
      categories: '##-burger',
      imagePath: 'assets/images/prodect_images/burger/burger.png',
    ),

    // --- SANDWICH ---
    Products_model(
      id: 5,
      name: "Sandwich Poulet",
      price: 400,
      categories: '##-sandwich',
      imagePath: 'assets/images/prodect_images/sandwich/sandwich_poli.png',
    ),
    Products_model(
      id: 6,
      name: "Sandwich Viande",
      price: 450,
      categories: '##-sandwich',
      imagePath: 'assets/images/prodect_images/sandwich/sandwich_viand.png',
    ),

    // --- TACCOS ---
    Products_model(
      id: 7,
      name: "Taccos Mix",
      price: 550,
      categories: '##-taccos',
      imagePath: 'assets/images/prodect_images/taccos/takos.png',
    ),

    // --- JUES (مشروبات) ---
    Products_model(
      id: 8,
      name: "Coca Cola 33cl",
      price: 150,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/canet_cocacola.png',
    ),
    Products_model(
      id: 9,
      name: "Coca Cola 1L",
      price: 250,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/cocacola_1L_.png',
    ),
    Products_model(
      id: 10,
      name: "Coca Cola 33cl",
      price: 150,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/cocacola_33Cl_.png',
    ),

    // --- KAICK ---
    Products_model(
      id: 11,
      name: "Kaick Special",
      price: 200,
      categories: '##-kaick',
      imagePath: 'assets/images/prodect_images/kaick/kaick.png',
    ),
  ];
}
