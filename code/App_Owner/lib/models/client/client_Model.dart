class Client_Model {
  String uID;
  String name;
  String number;
  String image;
  Client_Model({
    this.uID = 'client',
    this.name = 'Client',
    this.number = '',
    this.image = "",
  });

  factory Client_Model.fromMap(Map<String, dynamic> map) {
    return Client_Model(
      uID: map['uID'] as String? ?? 'cl-##',
      name: map['name'] as String? ?? 'Client',
      number: map['number'] as String? ?? '',
      image: map['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'uID': uID, 'name': name, 'number': number, 'image': image};
  }
}