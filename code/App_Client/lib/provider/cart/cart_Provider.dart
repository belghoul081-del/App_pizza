import 'package:app_pizza_client/models/model_cart/cart_Model.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';
import 'package:app_pizza_client/provider/cart/sepliment_Provider.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Cart_model> _carts = [];
  List<Cart_model> get carts => _carts;

  set carts(List<Cart_model> carts) {
    _carts = carts;
    notifyListeners();
  }

  ///دالة اضافة للسلة
  void add_Cart(Products_model cartItem, SeplimentProvider sepliment) {
    List<Sepliment_model> selectSepliment = sepliment.carts;
    if (productExist(cartItem)) {
      int index = _carts.indexWhere(
        (element) =>
            element.product.id == cartItem.id &&
            areSeplimentEqual(element.sepliment, selectSepliment),
      );
      if (index!= -1) {
         _carts[index].quantity = _carts[index].quantity + 1;
      }
     
    } else {
      _carts.add(
        Cart_model(
          product: cartItem,
          quantity: 1,
          sepliment: List.from(selectSepliment),
        ),
      );
    }
    notifyListeners();
  }

  ///دالة زيادة كمية المنتج
  void addQuantity(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) =>
          element.product.id == cartItem.product.id &&
          areSeplimentEqual(element.sepliment, cartItem.sepliment),
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
      notifyListeners();
    }
  }

  ///دالة انقاص كمية المنتج
  void removeQuantity(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) =>
          element.product.id == cartItem.product.id &&
          areSeplimentEqual(element.sepliment, cartItem.sepliment),
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity - 1;
      notifyListeners();
    } else if (index != -1 && _carts[index].quantity == 1) {
      removeFromCart(cartItem);
    }
  }

  ///تحقق اذا كان في الكارت قبلا

  bool productExist(Products_model product) {
    return _carts.indexWhere((element) => element.product.id == product.id) !=
        -1;
  }

  ///حذف من الكارد
  void removeFromCart(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) =>
          element.product.id == cartItem.product.id &&
          areSeplimentEqual(element.sepliment, cartItem.sepliment),
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
      total += _carts[i].quantity * _carts[i].product.price;
    }
    return total;
  }

  ///sepliment

  void add_Cart_sepliment(Products_model product, SeplimentProvider sepliment) {
    List<Sepliment_model> selectSepliment = List.from(sepliment.carts);
    if (productExist(product)) {
      int index = _carts.indexWhere(
        (element) =>
            element.product.id == product.id &&
            areSeplimentEqual(element.sepliment, selectSepliment),
      );
      if (index != -1) {
        _carts[index].quantity += 1;
      }
    } else {
      _carts.add(
        Cart_model(product: product, quantity: 1, sepliment: selectSepliment),
      );
    }
    notifyListeners();
  }

  bool areSeplimentEqual(
    List<Sepliment_model> list1,
    List<Sepliment_model> list2,
  ) {
    if (list1.length != list2.length) {
      return false;
    }
    for (var item in list2) {
      bool found = list2.any((item2) => item2.name == item.name);
      if (!found) {
        return false;
      }
    }
    return true;
  }
}
