import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';

class Products_model {
  final String id;
  String name;
  int price;
  String imagePath;
  final String categories;
  bool isAvailable;
  final List<Sepliment_model> supplements;

  Products_model copy() {
    return Products_model(
      id: id,
      name: name,
      price: price,
      categories: categories,
      imagePath: imagePath,
      isAvailable: isAvailable,
      supplements: List.from(supplements),
    );
  }

  Products_model({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    required this.imagePath,
    this.isAvailable = true,
    this.supplements = const [],
  });
/// send data product
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'categories': categories,
      'isAvailable': isAvailable,
      'supplements': supplements.map((s) => s.toMap()).toList(),
    };
  }

  /// get data product
  factory Products_model.fromMap(String id, Map<String, dynamic> map) {
    final rawSupplements = (map['supplements'] as List?) ?? [];
    return Products_model(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      imagePath: map['imagePath'] ?? '',
      categories: map['categories'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      supplements: rawSupplements.map((e) {
        // التحقق من نوع البيانات لحماية التطبيق من الانهيار
        if (e is String) {
          // إذا كانت البيانات القديمة مخزنة كنصوص
          return Sepliment_model(id: '', name: e, price: 0);
        } else if (e is Map) {
          // الحالة الطبيعية والصحيحة
          return Sepliment_model.fromMap(Map<String, dynamic>.from(e));
        }
        // في حال وجود بيانات غير معروفة
        return Sepliment_model(id: '', name: 'غير معروف', price: 0);
      }).toList(),
    
    );
  }
}

class Products_Data {
  /// مرجع بيانات تجريبية
  static List<Products_model> cards_of_Products = [
    Products_model(
      id: "P-001",
      name: "Pizza 4 Fromage",
      price: 600,
      categories: '##-pizza',
      imagePath: 'assets/images/prodect_images/pizza/pizza_4Fromage.png',
      supplements: const [],
    ),
  ];
}


