import 'package:app_pizza_owner/models/model_products/products_Model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  // القائمة أصبحت هنا داخل الـ Provider
  List<Products_model> _products = Products_Data.cards_of_Products;

  List<Products_model> get products => _products;


  void addProduct(Products_model product) {
    _products.add(product);
    notifyListeners(); // هنا السحر! هذا هو ما سيحدث الـ GridView
  }

  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
