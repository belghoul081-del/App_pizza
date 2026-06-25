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
    this.ProductId ='',
  });
}

class Sepliment_Data {
  static List<Sepliment_model> general_supplements = [
    Sepliment_model(
      name: "bordure",
      price: 50,
      id: "SP000",
      categories: '##-pizza',
    ),
    Sepliment_model(
      id: "SP001",
      name: "Mozzarella",
      price: 100,
      categories: '##-pizza',
    ),
    Sepliment_model(name: "chidar", price: 100, id: "S001"),
    Sepliment_model(name: "goda", price: 100, id: "S002"),
    Sepliment_model(name: "comonber", price: 100, id: "S003"),
    Sepliment_model(id: "S004", name: "Fromage Rouge", price: 100),
    Sepliment_model(id: "S005", name: "Poulet Fumé", price: 100),
  ];
}
