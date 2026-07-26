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

  factory Sepliment_model.fromMap(Map<String, dynamic> map) {
    return Sepliment_model(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      categories: map['categories'] ?? '',
      ProductId: map['ProductId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'categories': categories,
      'ProductId': ProductId,
    };
  }
}

class Sepliment_Data {
  static List<Sepliment_model> general_supplements = [];
}
