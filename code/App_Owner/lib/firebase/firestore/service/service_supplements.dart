import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:flutter/material.dart';

/// خدمة مساعدة للتخزين المركزي للإضافات في Firestore
class SupplementsFirestoreService {
  static const String collection = 'supplements';
  static const String docId = 'global';

  static Future<List<Sepliment_model>> loadGeneralSupplements() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> list = doc.data()!['supplements'] ?? [];
        return list.map((e) => Sepliment_model.fromMap(e)).toList();
      }
    } catch (e) {
      print('Error loading supplements: $e');
    }
    return [];
  }

  static Future<void> saveGeneralSupplements(
    List<Sepliment_model> supplements,
  ) async {
    final maps = supplements.map((s) => s.toMap()).toList();
    await FirebaseFirestore.instance.collection(collection).doc(docId).set({
      'supplements': maps,
    });
  }
}

class SupplementService {
  /// توليد ID فريد للإضافة
  static String generateUniqueId() {
    return "SP-${DateTime.now().microsecondsSinceEpoch.toString()}";
  }

  /// 🔄 دالة المزامنة: تحديث حقل supplements لكل منتج متأثر في Firestore مباشرة
  static Future<void> syncSupplementsToProducts() async {
    try {
      final productsSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      for (var doc in productsSnapshot.docs) {
        final productId = doc.id;
        final category = doc.data()['categories'] ?? '';

        // فلترة الإضافات المخصصة لهذا المنتج أو لفئته أو العامة
        final productSupplements = Sepliment_Data.general_supplements
            .where((s) {
              if (s.ProductId == productId) return true; // خاص بالمنتج
              if (s.categories == category && s.ProductId == '')
                return true; // خاص بالفئة
              if (s.categories == '' && s.ProductId == '') return true; // عام
              return false;
            })
            .map((s) => s.toMap())
            .toList();

        // تحديث قائمة الإضافات للمنتج في Firestore لتصل للزبون
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({'supplements': productSupplements});
      }
    } catch (e) {
      debugPrint('Error syncing supplements to products: $e');
    }
  }

  /// الحصول على الإضافات الافتراضية لفئة معينة (من القائمة المركزية)
  static List<Sepliment_model> getSupplementsForCategory(String categories) {
  return Sepliment_Data.general_supplements
      .where((s) =>
          (s.categories == categories && s.ProductId == '') ||
          (s.categories == '' && s.ProductId == ''))
      .toList();
}

  /// إضافة إضافة جديدة إلى القائمة المركزية مع تصنيفها، ثم حفظها
  static Future<void> addSupplement({
    required String name,
    required int price,
    required int type, // 0 = منتج محدد, 1 = فئة, 2 = عام
    required String categories, // فئة المنتج (تُستخدم إذا type=1)
    required Products_model productId, // المنتج المستهدف (يُستخدم إذا type=0)
  }) async {
    final newSupplement = Sepliment_model(
      id: generateUniqueId(),
      name: name,
      price: price,
      categories: type == 1 ? categories : '', // فئة محددة إذا كانت الفئة
      ProductId: type == 0 ? productId.id : '', // منتج محدد إذا كان خاصاً
    );

    Sepliment_Data.general_supplements.add(newSupplement);

    // حفظ القائمة المركزية في Firestore
    await SupplementsFirestoreService.saveGeneralSupplements(
      Sepliment_Data.general_supplements,
    );

    await syncSupplementsToProducts();

    if (type == 0) {
      productId.supplements.add(newSupplement);
    }
  }

  /// تعديل إضافة موجودة في القائمة المركزية وحفظها
  static Future<void> editSupplement({
    required String id,
    required String newName,
    required int newPrice,
  }) async {
    final index = Sepliment_Data.general_supplements.indexWhere(
      (s) => s.id == id,
    );
    if (index == -1) return;
    Sepliment_Data.general_supplements[index].name = newName;
    Sepliment_Data.general_supplements[index].price = newPrice;
    await SupplementsFirestoreService.saveGeneralSupplements(
      Sepliment_Data.general_supplements,
    );
    await syncSupplementsToProducts();
  }

  /// حذف إضافة من القائمة المركزية وحفظها
  static Future<void> deleteSupplement({required String id}) async {
    Sepliment_Data.general_supplements.removeWhere((item) => item.id == id);
    await SupplementsFirestoreService.saveGeneralSupplements(
      Sepliment_Data.general_supplements,
    );
    await syncSupplementsToProducts();
  }

  static Future<void> initSupplements() async {
    final loaded = await SupplementsFirestoreService.loadGeneralSupplements();
    Sepliment_Data.general_supplements = loaded;
  }
}
