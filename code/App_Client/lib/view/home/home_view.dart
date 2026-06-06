import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:app_pizza_client/view/home/categories_home.dart';
import 'package:app_pizza_client/models/categorymodel/category_Model.dart';
import 'package:app_pizza_client/view/home/lo_noti_acc.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_size.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

// ignore: camel_case_types
class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar_home(context, _currentIndex, (
        value,
      ) {
        if (value == 0) {
          setState(() {
            _currentIndex = value;
          });
        } else if (value == 1) {
          Navigator.of(context).pushNamed("order");
        } else if (value == 2) {
          Navigator.of(context).pushNamed("chat");
        }
      }),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: screenWidht,
              child: Image.asset(
                "assets/images/home_images/logo_home.png",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Bar_Location_Notificaion_Bccount( context: context),
                  categories(
                    context: context,
                    selectedIndex: _selectedCategoryIndex,
                    onCategorySelected: (index) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      print(
                        "تم اختيار فئة: ${Category_Data.categories[index].name}",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
