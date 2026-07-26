import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';

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