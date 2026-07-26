class OrderItem_Model {
  final String productId;
  final String name;
  final String imagePath;
  final int price;
  final int quantity;
  final List<Map<String, dynamic>> supplements;

  OrderItem_Model({
    required this.productId,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.quantity,
    this.supplements = const [],
  });

  int get totalPrice => price * quantity;

  factory OrderItem_Model.fromMap(Map<String, dynamic> map) {
    final rawSupplements = (map['supplements'] as List?) ?? const [];
    return OrderItem_Model(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      supplements: rawSupplements.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
  }
}
