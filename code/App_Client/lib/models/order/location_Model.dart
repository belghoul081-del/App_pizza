/// موقع جغرافي بسيط (خط عرض/طول) + عنوان نصي اختياري للعرض.
class Location_Model {
  final double lat;
  final double lng;

  Location_Model({required this.lat, required this.lng});

  bool get isSet => lat != 0 || lng != 0;

  Map<String, dynamic> toMap() => {'lat': lat, 'lng': lng};

  factory Location_Model.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Location_Model(lat: 0, lng: 0);
    return Location_Model(
      lat: (map['lat'] as num?)?.toDouble() ?? 0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0,
    );
  }
}
