import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/firebase/firestore/service/products_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductsFirestoreService _service = ProductsFirestoreService();
  StreamSubscription<List<Products_model>>? _subscription;

  List<Products_model> _products = [];
  List<Products_model> get products => _products;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  ProductProvider() {
    _listenToProducts();
  }

  void _listenToProducts() {
    _subscription = _service.streamProducts().listen(
      (products) {
        _products = products;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = "Failed to fetch products: $e";
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// إضافة منتج جديد (يرفع الصورة إلى Storage ثم يكتب المستند في Firestore).
  /// لا داعي لتحديث `_products` يدويًا هنا: الـ Stream سيستقبل التحديث تلقائيًا.
  Future<void> addProduct(Products_model product, File imageFile) async {
    await _service.addProduct(product: product, imageFile: imageFile);
  }

  Future<void> updateProduct(
    Products_model product, {
    File? newImageFile,
  }) async {
    await _service.updateProduct(product, newImageFile: newImageFile);
  }

  Future<void> removeProduct(String productId) async {
    await _service.deleteProduct(productId);
  }

  Products_model? getById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
