/// نسخة قراءة فقط لتطبيق الزبون من بيانات المالك المخزّنة في مجموعة
class Admin_Model {
  final String name;
  final String address;
  final String image;
  final String number;
  final String number2;
  final bool isOpen;

  static const String defaultImage =
      "assets/images/home_images/launch_Icon.png";

  Admin_Model({
    this.name = "infinity",
    this.address = 'siamital 400',
    this.image = defaultImage,
    this.number =  "0000000000",
    this.number2 = '1111111111',
    this.isOpen = true,
  });

  factory Admin_Model.fromMap(Map<String, dynamic> map) {
    return Admin_Model(
      name: map['name'] ?? "infinity",
      address: map['addres'] ?? 'siamital 400',
      image: map['image'] ?? defaultImage,
      number: map['number'] ?? "0559853037",
      number2: map['number2'] ?? '0779853037',
      isOpen: map['isOpen'] ?? true,
    );
  }
}