import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';

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

class Cart_Data {
  static List<Cart_model> cart_of_Products = [
    // --- PIZZA ---
    Cart_model(product: Products_Data.cards_of_Products[1], quantity: 1),
  ];
}
