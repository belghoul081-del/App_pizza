class Announcement_Model {
  String image; //1200x400
  int offer;
  Announcement_Model({required this.image, required this.offer});
}

class Announcement_Data {
  static List<Announcement_Model> announcement = [
    Announcement_Model(
      image: 'assets/images/home_images/announc/announc.png',
      offer: 20,
    ),
    Announcement_Model(
      image: 'assets/images/home_images/announc/announc_II.png',
      offer: 10,
    ),
    Announcement_Model(
      image: 'assets/images/home_images/announc/announc_II.png',
      offer: 10,
    ),
  ];
}
