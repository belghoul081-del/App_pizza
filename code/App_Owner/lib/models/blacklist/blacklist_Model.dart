import 'package:cloud_firestore/cloud_firestore.dart';

class Blacklist_Model {
  final String uID;
  final String name;
  final String number;
  final String image;
  final DateTime? blockedAt;

  Blacklist_Model({
    required this.uID,
    required this.name,
    required this.number,
    required this.image,
    this.blockedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'image': image,
      'blockedAt': FieldValue.serverTimestamp(),
    };
  }

  factory Blacklist_Model.fromMap(String uID, Map<String, dynamic> map) {
    return Blacklist_Model(
      uID: uID,
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      image: map['image'] ?? '',
      blockedAt: map['blockedAt'] is Timestamp
          ? (map['blockedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
