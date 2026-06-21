import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';

import 'package:flutter/material.dart';

class SeplimentProvider with ChangeNotifier {
  List<Sepliment_model> _selectSepliment = [];
  List<Sepliment_model> get carts => _selectSepliment;

  void selectSepliment(Sepliment_model sepliment, bool chek) {
    if (chek == true) {
      _selectSepliment.add(sepliment);
    } else {
      _selectSepliment.removeWhere((item) => item.name == sepliment.name);
    }
    notifyListeners();
  }

  int calculatePrice(int productprice) {
    int newPrice = _selectSepliment.fold(0, (sum, item) => sum + item.price);
    return newPrice + productprice;
  }

  void clearSepliment() {
    _selectSepliment.clear();
    notifyListeners();
  }
}
