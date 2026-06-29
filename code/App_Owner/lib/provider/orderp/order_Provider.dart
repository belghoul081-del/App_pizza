import 'package:flutter/material.dart';
import 'package:app_pizza_owner/models/order/order_Model.dart';

class OrderProvider with ChangeNotifier {
  // هذا هو "المخزن المركزي" لكل الطلبات في التطبيق
  List<Order_Model> allOrders = order_Data().order;

  // دالة لجلب البيانات من Firebase (ستكتبها لاحقاً)
  Future<void> fetchOrders() async {
    // هنا سيكون كود Firestore لجلب الطلبات وتخزينها في allOrders
    // allOrders = ...;
    notifyListeners(); // إخبار الواجهة أن البيانات تغيرت
  }
}
