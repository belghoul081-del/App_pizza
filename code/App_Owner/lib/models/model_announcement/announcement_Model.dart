class Announcement_Model {
  final String id;
  String imagePath; //1200x400
  Announcement_Model({required this.id, required this.imagePath});
  Map<String, dynamic> toMap() {
    return {'imagePath': imagePath};
  }

  factory Announcement_Model.fromMap(String id,Map<String, dynamic> map) {
    return Announcement_Model(
      id : id,
      imagePath: map['imagePath'] ?? '');
  }
}
