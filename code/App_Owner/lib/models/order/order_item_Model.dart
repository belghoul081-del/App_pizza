import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';

/// عنصر داخل الطلب (لقطة/نسخة عن المنتج وقت الطلب، وليس رابطًا حيًا بالمنتج،
/// حتى لو حُذف المنتج أو تغيّر سعره لاحقًا يبقى الطلب القديم يعرض بياناته الصحيحة وقت الطلب)
class OrderItem_Model {
  final String productId;
  final String name;
  final String imagePath;
  final int price;
  final int quantity;
  final List<Sepliment_model> supplements; 

  OrderItem_Model({
    required this.productId,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.quantity,
    this.supplements = const [],
  });

  int get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imagePath': imagePath,
      'price': price,
      'quantity': quantity,
      'supplements': supplements.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderItem_Model.fromMap(Map<String, dynamic> map) {
  List<Sepliment_model> supplementsList = [];
    final suppData = map['supplements'];
    
    if (suppData is List) {
      for (var item in suppData) {
        if (item is Map) {
          // التعديل تحويل الـ Map القادم من فايربيز إلى Sepliment_model
          supplementsList.add(Sepliment_model.fromMap(Map<String, dynamic>.from(item)));
        } else if (item is String) {
          // إجراء احتياطي: في حال كانت هناك بيانات قديمة مخزنة كنصوص فقط
          supplementsList.add(Sepliment_model(id: '', name: item, price: 0));
        }
      }
    }
    
    return OrderItem_Model(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      supplements: supplementsList,
    );
  }
}

