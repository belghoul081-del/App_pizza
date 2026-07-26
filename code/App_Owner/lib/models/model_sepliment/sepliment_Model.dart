class Sepliment_model {
  final String id;
  String name;
  int price;
  final String categories;
  final String ProductId;

  Sepliment_model({
    required this.id,
    required this.name,
    required this.price,
    this.categories = '',
    this.ProductId = '',
  });

  /// تحويل الإضافة إلى Map 
  /// لتُخزَّن ( كعنصر ضمن مصفوفة supplements داخل مستند المنتج في Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'categories': categories,
      'ProductId': ProductId,
    };
  }

  /// بناء الإضافة من بيانات قادمة من Firestore
  factory Sepliment_model.fromMap(Map<String, dynamic> map) {
    return Sepliment_model(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      categories: map['categories'] ?? '',
      ProductId: map['ProductId'] ?? '',
    );
  }
}

class Sepliment_Data {
  /// ملاحظة: هذه قائمة محلية تُستخدم فقط كـ "قيم افتراضية" عند إنشاء منتج جديد
  /// (خطوة إعداد أولية للإضافات الشائعة حسب الفئة). بعد إضافة المنتج، تُحفظ
  /// إضافاته الفعلية داخل مستند المنتج في Firestore ولا علاقة لها بهذه القائمة بعد ذلك.
  static List<Sepliment_model> general_supplements = [];
}
