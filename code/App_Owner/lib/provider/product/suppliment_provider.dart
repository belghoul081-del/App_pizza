import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:flutter/material.dart';

class SupplimentProvider extends ChangeNotifier {
  // القائمة أصبحت هنا داخل الـ Provider
  List<Sepliment_model> _suppliment = List.from(
    Sepliment_Data.general_supplements,
  );

  List<Sepliment_model> get suppliment => _suppliment;

  void removeSuppliment(String supplimentId) async {
    _suppliment.removeWhere((item) => item.id == supplimentId);
    notifyListeners();
  }
}
