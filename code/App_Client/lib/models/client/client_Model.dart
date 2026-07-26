class Client_Model {
  String uID;
  String name;
  String image;
  String number;

  Client_Model({
    this.uID = '',
    this.number = '',
    this.name = 'Client',
    this.image = "assets/images/profila_client.png",
  });
  Map<String, dynamic> toMap( String authenticatedUid) {
    uID = authenticatedUid;
    return {'uID':uID,'name': name, 'number': number, 'image': image};
  }

  factory Client_Model.fromMap(Map<String, dynamic> map) {
    return Client_Model(
      uID: map['uID'] ?? '',
      name: map['name'] ?? 'Client',
      number: map['number'] ?? '',
      image: map['image'] ?? "assets/images/profila_client.png",
    );
  }
}
