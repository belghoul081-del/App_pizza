import 'package:app_pizza_owner/models/model_sepliment/sepliment_Model.dart';

class SupplementService {
  static List<Sepliment_model> getSupplementsForCategory(String category) {
    if (category == '##-jues') {
      return [];
    }

    List<Sepliment_model> specific = getOnlySupplements(category);
    List<Sepliment_model> global = getAllSupplements(category);
    return [...specific, ...global];
  }

  static List<Sepliment_model> getOnlySupplements(String category) {
    return Sepliment_Data.general_supplements.where((s) {
      return s.categories == category;
    }).toList();
  }

  static List<Sepliment_model> getAllSupplements(String category) {
    return Sepliment_Data.general_supplements.where((s) {
      return s.categories == '';
    }).toList();
  }

  static String generateUniqueId() {
    return "SP-${DateTime.now().microsecondsSinceEpoch.toString()}";
  }

  static Future<void> addSupplement({
    required String name,
    required int price,
    required bool isSpecific,
    required String categories, // هذه هي الكاتيجوري الخاصة بالمنتج الحالي
  }) async {
    // 1. توليد ID فريد
    String newId = generateUniqueId();

    // 2. إنشاء كائن الإضافة الجديد
    // إذا كانت 'isSpecific' صحيحة نضع الكاتيجوري، وإلا نتركها '' لتصبح عامة
    final newSupplement = Sepliment_model(
      id: newId,
      name: name,
      price: price,
      categories: isSpecific ? categories : '',
    );

    // 3. الإضافة للقائمة الرئيسية (Sepliment_Data)
    // بما أن القائمة هي المصدر الأساسي، فإن الإضافة إليها ستجعلها تظهر
    // تلقائياً في الدوال الأخرى مثل getSupplementsForCategory
    Sepliment_Data.general_supplements.add(newSupplement);

    // ملاحظة: إذا كنت تستخدم قاعدة بيانات خارجية (مثل Firebase)،
    // قم هنا باستدعاء دالة الـ save أو الـ set الخاصة بها.
  }
}
