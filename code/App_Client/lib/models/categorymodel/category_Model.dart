class Category_model {
  final int id;
  final String name;
  final String imagePath;
  final double size;
  Category_model({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.size,
  });
}

class Category_Data {
  static List<Category_model> categories = [
    Category_model(
      id: 1,
      name: "  sandwich   ",
      imagePath: "assets/images/categories_images/categories_sandwich.png",
      size: 0.1,
    ),
    Category_model(
      id: 2,
      name: "  pizza   ",
      imagePath: "assets/images/categories_images/categories_pizza.png",
      size: 0.1,
    ),
    Category_model(
      id: 3,
      name: "  burger   ",
      imagePath: "assets/images/categories_images/categories_burger.png",
      size: 0.3,
    ),
    Category_model(
      id: 4,
      name: "  jues   ",
      imagePath: "assets/images/categories_images/categories_jues.png",
      size: 0.2,
    ),
    Category_model(
      id: 5,
      name: "  taccos   ",
      imagePath: "assets/images/categories_images/categories_taccos.png",
      size: 0.2,
    ),

    Category_model(
      id: 6,
      name: "  kaick   ",
      imagePath: "assets/images/categories_images/categories_kaick.png",
      size: 0.7,
    ),
  ];
}
