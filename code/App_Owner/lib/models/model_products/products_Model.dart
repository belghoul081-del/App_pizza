import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_owner/service/service_supplements.dart';

class Products_model {
  final String id;
  String name;
   int price;
  final String imagePath;
  final String categories;
  bool isAvailable;
  final List<Sepliment_model> supplements;

  

  Products_model({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    // required this.isAvailable,
    required this.imagePath,
    this.isAvailable = true,
    this.supplements = const [],
  });
}

class Products_Data {
  static List<Products_model> cards_of_Products = [
    // --- PIZZA ---
    Products_model(
      id: "P-001",
      name: "Pizza 4 Fromage",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),
    Products_model(
      id: "P-002",
      name: "Pizza Vegitaria",
      price: 550,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),
    Products_model(
      id: "P-003",
      name: "Pizza Viande",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Viande.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),
    Products_model(
      id: "P-004",
      name: "Pizza 4 Fromage",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),
    Products_model(
      id: "P-005",
      name: "Pizza Vegitaria",
      price: 550,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),
    Products_model(
      id: "P-006",
      name: "Pizza Viande",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_Viande.png',
      supplements: SupplementService.getSupplementsForCategory('##-pizza'),
    ),

    // --- BURGER ---
    Products_model(
      id: "B-001",
      name: "Classic Burger",
      price: 450,
      categories: '##-burger',
      imagePath: 'assets/images/prodect_images/burger/burger.png',
      supplements: SupplementService.getSupplementsForCategory('##-burger'),
    ),

    // --- SANDWICH ---
    Products_model(
      id: "S-001",
      name: "Sandwich Poulet",
      price: 400,
      categories: '##-sandwich',
      imagePath: 'assets/images/prodect_images/sandwich/sandwich_poli.png',
      supplements: SupplementService.getSupplementsForCategory('##-sandwich'),
    ),
    Products_model(
      id: "S-002",
      name: "Sandwich Viande",
      price: 450,
      categories: '##-sandwich',
      imagePath: 'assets/images/prodect_images/sandwich/sandwich_viand.png',
      supplements: SupplementService.getSupplementsForCategory('##sandwich'),
      isAvailable: false,
    ),

    // --- TACCOS ---
    Products_model(
      id: "T-001",
      name: "Taccos Mix",
      price: 550,
      categories: '##-taccos',
      imagePath: 'assets/images/prodect_images/taccos/takos.png',
      supplements: SupplementService.getSupplementsForCategory('##-taccos'),
    ),

    // --- JUES (مشروبات) ---
    Products_model(
      id: "J-coca_C33",
      name: "Coca Cola 33cl",
      price: 150,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/canet_cocacola.png',
      supplements: SupplementService.getSupplementsForCategory(''),
    ),
    Products_model(
      id: "J-coca_1",
      name: "Coca Cola 1L",
      price: 250,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/cocacola_1L_.png',
      supplements: SupplementService.getSupplementsForCategory(''),
    ),
    Products_model(
      id: "S-coca_33",
      name: "Coca Cola 33cl",
      price: 150,
      categories: '##-jues',
      imagePath: 'assets/images/prodect_images/jues/cocacola_33Cl_.png',
      supplements: SupplementService.getSupplementsForCategory(''),
    ),

    // --- KAICK ---
    Products_model(
      id: "K-001",
      name: "Kaick Special",
      price: 200,
      categories: '##-kaick',
      imagePath: 'assets/images/prodect_images/kaick/kaick.png',
      supplements: SupplementService.getSupplementsForCategory('##-kaick'),
    ),
  ];
}
