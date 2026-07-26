import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';

class Products_model {
  final String id;
  String name;
  int price;
  String imagePath;
  final String categories;
  bool isAvailable;
  bool favorit;

  final List<Sepliment_model> supplements;

  Products_model({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    required this.imagePath,
    this.isAvailable = true,
    this.favorit = false,
    this.supplements = const [],
  });

  Products_model copy() {
    return Products_model(
      id: id,
      name: name,
      price: price,
      categories: categories,
      imagePath: imagePath,
      isAvailable: isAvailable,
      favorit: false,
      supplements: List.from(supplements),
    );
  }

  /// بناء المنتج من مستند Firestore
  factory Products_model.fromMap(String id, Map<String, dynamic> map) {
    final rawSupplements = (map['supplements'] as List?) ?? [];
    List<Sepliment_model> supplements = [];
    for (final e in rawSupplements) {
      try {
        supplements.add(Sepliment_model.fromMap(Map<String, dynamic>.from(e)));
      } catch (_) {
        // نتجاهل عنصر إضافة تالف بدل تعطيل المنتج كله
      }
    }
    return Products_model(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      imagePath: map['imagePath'] ?? '',
      categories: map['categories'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      favorit: map['favorit'] ?? false,
      supplements: supplements,
    );
  }
}


