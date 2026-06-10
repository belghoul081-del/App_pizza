import 'package:flutter/material.dart';

class cartController {
  // static void add_Quantity(Function(int) update, int currentQuantity) {
  //   update(currentQuantity + 1);
  // }
  static int add_qq(int current) => current + 1;

  // دالة الحذف
  // static void remove_Quantity(Function(int) update, int currentQuantity) {
  //   if (currentQuantity > 0) {
  //     update(currentQuantity - 1);
  //   }
  // }
  static int re_qq(int current) {
    if (current > 1) {
      return current-1;
    } else {
      return  1;
    }
  }
}
