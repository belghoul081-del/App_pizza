import 'package:flutter/material.dart';
import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';

/// ✅ إعادة كتابة كاملة ومبسّطة: لم يعد هذا الـ Provider مسؤولًا عن "جلب"
/// الإضافات من أي مكان إطلاقًا (كان يقرأ من مستند خاطئ `supplements/global`
/// لا علاقة له بالمنتج المعروض، ولا يكتب فيه المالك شيئًا). الإضافات
/// الحقيقية تصل الآن جاهزة ضمن كائن المنتج نفسه (`product.supplements`)
/// القادم من Firestore، وهذا الـ Provider يدير فقط "أيها مُختار حاليًا"
/// أثناء فتح نافذة الاختيار.
class SupplementSelectionProvider extends ChangeNotifier {
  final Set<String> _selectedIds = {};
  Set<String> get selectedIds => _selectedIds;

  void selectSepliment(Sepliment_model item, bool value) {
    if (value) {
      _selectedIds.add(item.id);
    } else {
      _selectedIds.remove(item.id);
    }
    notifyListeners();
  }

  bool isSelected(String id) => _selectedIds.contains(id);

  /// ✅ يأخذ الآن قائمة إضافات هذا المنتج تحديدًا كمعامل (بدل الاعتماد على
  /// قائمة داخلية مجلوبة من مكان خاطئ)، فيبقى صحيحًا لأي منتج تفتح نافذته.
  int calculatePrice(int basePrice, List<Sepliment_model> availableSupplements) {
    int extra = 0;
    for (final s in availableSupplements) {
      if (_selectedIds.contains(s.id)) {
        extra += s.price;
      }
    }
    return basePrice + extra;
  }

  /// الإضافات المختارة فعليًا من قائمة إضافات هذا المنتج، لإضافتها للسلة.
  List<Sepliment_model> getSelectedSupplements(
    List<Sepliment_model> availableSupplements,
  ) {
    return availableSupplements
        .where((s) => _selectedIds.contains(s.id))
        .toList();
  }

  void clearSelection() {
    _selectedIds.clear();
    notifyListeners();
  }
}
