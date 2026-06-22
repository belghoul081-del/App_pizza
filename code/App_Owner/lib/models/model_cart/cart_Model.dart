import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';

class Cart_model {
  final Products_model product;
  int quantity;
  List<Sepliment_model> sepliment;
  String get uniqueId =>
      "${product.id}_${sepliment.map((e) => e.name).join('_')}";

  Cart_model({
    required this.product,
    this.quantity = 1,
    this.sepliment = const [],
  });

  int get pricePerUnit {
    int seplimentPrice = sepliment.fold(0, (sum, item) => sum + item.price);
    return product.price + seplimentPrice;
  }
}

// class Cart_Data {
//   static List<Cart_model> cart_of_Products = [
//     // --- PIZZA ---
//     Cart_model(
//       name: "Pizza 4 Fromage",
//       price: 600,
//       imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
//     ),
//     Cart_model(
//       name: "Pizza Vegitaria",
//       price: 550,
//       imagePath: 'assets/images/prodect_images/pizza/pizza_Vegitaria.png',
//     ),
//     Cart_model(
//       name: "Coca Cola 33cl",
//       price: 150,
//       imagePath: 'assets/images/prodect_images/jues/canet_cocacola.png',
//     ),
//   ];
// }
