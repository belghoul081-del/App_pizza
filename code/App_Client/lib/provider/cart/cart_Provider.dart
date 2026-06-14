import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Cart_model> _carts = [];
  List<Cart_model> get carts => _carts;

  set carts(List<Cart_model> carts) {
    _carts = carts;
    notifyListeners();
  }

  ///دالة اضافة للسلة
  void add_Cart(Products_model product) {
    if (productExist(product)) {
      int index = _carts.indexWhere(
        (element) => element.product.id == product.id,
      );
      _carts[index].quantity = _carts[index].quantity + 1;
    } else {
      _carts.add(Cart_model(product: product, quantity: 1));
    }
    notifyListeners();
  }

  ///دالة زيادة كمية المنتج
  void addQuantity(Products_model product) {
    int index = _carts.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
      notifyListeners();
    }
  }

  ///دالة انقاص كمية المنتج
  void removeQuantity(Products_model product) {
    int index = _carts.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity - 1;
      notifyListeners();
    } else if (index != -1 && _carts[index].quantity == 1) {
      removeFromCart(product);
    }
  }

  ///تحقق اذا كان في الكارت قبلا

  bool productExist(Products_model product) {
    return _carts.indexWhere((element) => element.product.id == product.id) !=
        -1;
  }

  ///حذف من الكارد
  void removeFromCart(Products_model product) {
    int index = _carts.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      _carts.removeAt(index);
      notifyListeners();
    }
  }
///سعر اجمالي 
  int total_Price_Cart() {
    int total = 0;
    for (var i = 0; i < _carts.length; i++) {
      total +=
          _carts[i].quantity * _carts[i].product.price;
    }
    return total;
  }
}
