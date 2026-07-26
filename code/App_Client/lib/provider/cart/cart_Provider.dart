import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Cart_model> _carts = [];
  List<Cart_model> get carts => _carts;

  set carts(List<Cart_model> carts) {
    _carts = carts;
    notifyListeners();
  }

  void add_Cart(Products_model cartItem,  List<Sepliment_model> selectedSupplements) {
    String newId =
        "${cartItem.id}_${selectedSupplements.map((e) => e.id).join('_')}";

    int index = _carts.indexWhere((element) => element.uniqueId == newId);
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
    } else {
      _carts.add(
        Cart_model(
          product: cartItem,
          quantity: 1,
          sepliment: List.from(selectedSupplements),
        ),
      );
    }
    notifyListeners();
  }

  void addQuantity(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) => element.uniqueId == cartItem.uniqueId,
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
      notifyListeners();
    }
  }

  void removeQuantity(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) => element.uniqueId == cartItem.uniqueId,
    );
    if (index != -1) {
      if (_carts[index].quantity > 1) {
        _carts[index].quantity = _carts[index].quantity - 1;
      } else {
        removeFromCart(cartItem);
        return;
      }
    }
    notifyListeners();
  }

  bool productExist(Cart_model cartItem) {
    return _carts.indexWhere(
          (element) => element.uniqueId == cartItem.uniqueId,
        ) !=
        -1;
  }

  void removeFromCart(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) => element.uniqueId == cartItem.uniqueId,
    );
    if (index != -1) {
      _carts.removeAt(index);
      notifyListeners();
    }
  }

  int total_Price_Cart() {
    int total = 0;
    for (var i = 0; i < _carts.length; i++) {
      total += _carts[i].quantity * _carts[i].pricePerUnit;
    }
    return total;
  }
}
