import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/firebase/firestore/service/products_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductsFirestoreService _service = ProductsFirestoreService();
  StreamSubscription<List<Products_model>>? _subscription;

  List<Products_model> _products = [];
  List<Products_model> get products => _products;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

    final Completer<void> _readyCompleter = Completer<void>();
  Future<void> get ready => _readyCompleter.future;


  ProductProvider() {
    _subscription = _service.streamProducts().listen(
      (products) {
        _products = products;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = "فشل جلب المنتجات: $e";
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
