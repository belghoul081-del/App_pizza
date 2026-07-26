import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Admin_Model {
  String name;
  String addres;
  String image;
  
  static const String defaultImage = "assets/images/profila_pucture.png";
  String number;
  String number2;
  bool isOpen;

  Admin_Model({
     this.name ='infinity',
     this.number = '0000000000',
    this.number2 = '0000000000',
    this.image = "assets/images/profila_pucture.png",
    this.addres = 'siamital 400',
    this.isOpen = true,
  });

  /// get data
  factory Admin_Model.fromMap(Map<String, dynamic> map) {
    return Admin_Model(
      name: map['name'] ?? "not name",
      number: map['number'] ?? "not number",
      addres: map['addres'] ?? 'siamital 400',
      image: map['image'] ?? "assets/images/profila_pucture.png",
      number2: map['number2'] ?? '0779853037',
        isOpen: map['isOpen'] ?? true,
    );
  }

  /// send data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'addres': addres,
      'image': image,
      'number2': number2,
        'isOpen': isOpen,
    };
  }
}

class AdminNameDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetdataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) return CircularProgressIndicator();

        if (provider.admin.isEmpty) return Text("No data");

        return Text(provider.admin[0].name);
      },
    );
  }
}
