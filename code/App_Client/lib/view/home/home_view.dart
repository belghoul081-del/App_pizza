import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

// ignore: camel_case_types
class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar_home(context, _currentIndex, (
        value,
      ) {
        if (value == 0 ) {
          setState(() {
            _currentIndex = value;
          });
        }
        else if (value == 1) {
          Navigator.of(context).pushNamed("order");
        }
        else if (value == 2) {
          Navigator.of(context).pushNamed("chat");
        }
      }),
      body: Container(),
    );
  }
}
