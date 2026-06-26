import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:app_pizza_owner/service/service_supplements.dart';

class Service_Addproduct {
  static String generateUniqueId(String categories) {
    const categoryPrefixes = {
      '##-pizza': 'P',
      '##-burger': 'B',
      '##-sandwich': 'S',
      '##-taccos': 'T',
      '##-jues': 'J',
      '##-kaick': 'K',
    };
    final prefix = categoryPrefixes[categories] ?? 'ZXZ';
    final timestamp = DateTime.now().microsecondsSinceEpoch.toString();

    return "$prefix-$timestamp";
  }

  static Future<void> addProduct({
    required String name,
    required int price,
    required int type,
    required String categories,
    required Products_model productId,
    required String imagePath,
  }) async {
    String newId = generateUniqueId(categories);
    final newSupplement = Products_model(
      id: newId,
      name: name,
      price: price,
      categories: categories,
      imagePath: imagePath,
      supplements: SupplementService.getSupplementsForCategory(categories),
    );
    Products_Data.cards_of_Products.add(newSupplement);
  }
}
