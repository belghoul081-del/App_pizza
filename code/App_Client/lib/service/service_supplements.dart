import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';

class SupplementService {
  static List<Sepliment_model> getSupplementsForCategory(String category) {
    if (category == '##-jues') {
      return [];
    }

    List<Sepliment_model> specific = getOnlySupplements(category);
    List<Sepliment_model> global = getAllSupplements(category);
    return [...specific, ...global];
  }

  static List<Sepliment_model> getOnlySupplements(String category) {
    return Sepliment_Data.general_supplements.where((s) {
      return s.categories == category;
    }).toList();
  }

  static List<Sepliment_model> getAllSupplements(String category) {
    return Sepliment_Data.general_supplements.where((s) {
      return s.categories == '';
    }).toList();
  }

  static String generateUniqueId() {
    return "SP-${DateTime.now().microsecondsSinceEpoch.toString()}";
  }

  static Future<void> addSupplement({
    required String name,
    required int price,
    required int type,
    required String categories,
    required Products_model productId,
  }) async {
    String newId = generateUniqueId();
    final newSupplement = Sepliment_model(
      id: newId,
      name: name,
      price: price,
      categories: (type == 1) ? productId.categories : '',
      ProductId: (type == 0) ? productId.id : '',
    );
    Sepliment_Data.general_supplements.add(newSupplement);
  }

  static List<Sepliment_model> getSupplementsForProductsId(
    Products_model product,
  ) {
    return Sepliment_Data.general_supplements.where((s) {
      if (s.categories == '' && s.ProductId == '') {
        return true;
      }
      if (s.categories == product.categories && s.ProductId == '') {
        return true;
      }
      if (s.categories == product.categories && s.ProductId == product.id) {
        return true;
      }
      return false;
    }).toList();
  }

  static Future<void> deleteSupplement({required String id}) async {
    Sepliment_Data.general_supplements.removeWhere((item) => item.id == id);
  }
}
