class Sepliment_model {
  // final int id;
  final String name;
  final int price;

  Sepliment_model({
    // required this.id,
    required this.name,
    required this.price,
  });
}

class Sepliment_Data {
  static List<Sepliment_model> sepliment = [
    // --- PIZZA ---
    Sepliment_model(name: "chidar", price: 100),
    Sepliment_model(name: "goda", price: 100),
    Sepliment_model(name: "comonber", price: 100),
  ];
}
