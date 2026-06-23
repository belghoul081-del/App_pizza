import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';

class SupplementService {
  static List<Sepliment_model> getSupplementsForCategory(String category) {
    if (category == '##-jues') {
      return [];
    }

    return Sepliment_Data.general_supplements.where((s) {
      return s.categories == '' || s.categories == category;
    }).toList();
  }
}
