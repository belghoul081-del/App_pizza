import 'package:app_owner/models/model_cart/cart_Model.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:app_owner/provider/cart/sepliment_Provider.dart';
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
    String newId =
        "${cartItem.id}_${selectSepliment.map((e) => e.name).join('_')}";

    int index = _carts.indexWhere((element) => element.uniqueId == newId);
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
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
      (element) => element.uniqueId == cartItem.uniqueId,
    );
    if (index != -1) {
      _carts[index].quantity = _carts[index].quantity + 1;
      notifyListeners();
    }
  }

  ///دالة انقاص كمية المنتج
  void removeQuantity(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) => element.uniqueId == cartItem.uniqueId,
    );
    if (index != -1) {
      if (_carts[index].quantity > 1) {
        _carts[index].quantity = _carts[index].quantity - 1;
      }
    } else if (index != -1 && _carts[index].quantity == 1) {
      removeFromCart(cartItem);
    }
    notifyListeners();
  }

  ///تحقق اذا كان في الكارت قبلا

  bool productExist(Cart_model cartItem) {
    return _carts.indexWhere(
          (element) => element.uniqueId == cartItem.uniqueId,
        ) !=
        -1;
  }

  ///حذف من الكارد
  void removeFromCart(Cart_model cartItem) {
    int index = _carts.indexWhere(
      (element) => element.uniqueId == cartItem.uniqueId,
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
      total += _carts[i].quantity * _carts[i].pricePerUnit;
    }
    return total;
  }
}
