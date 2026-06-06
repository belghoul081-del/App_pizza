import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';
import 'package:app_pizza_client/view/home/announcement_home.dart';
import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:app_pizza_client/view/home/categories_home.dart';
import 'package:app_pizza_client/models/model_category/category_Model.dart';
import 'package:app_pizza_client/view/home/lo_noti_acc.dart';
import 'package:app_pizza_client/widget/bar.dart';
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

  int _totalBarcounter = Announcement_Data.announcement.length;

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    final List cards = [
      Container(height: 40, width: 40, color: Colors.green),
      Container(height: 40, width: 40, color: Colors.green),
      Container(height: 40, width: 40, color: Colors.green),
    ];
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
            /// logo
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
                  /// bar
                  Bar_Location_Notificaion_Bccount(context: context),

                  /// announcement
                  Announcement_home(totalBar: _totalBarcounter),

                  /// categories
                  SizedBox(height: context.heightPct(1)),
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

                  DashedLineDivider(
                    height: context.heightPct(0.2),
                    dashWidth: context.heightPct(3),
                    dashSpace: context.heightPct(2),
                    color: ColorApp_Icon_border.bottonbrown,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10, // المسافة الأفقية بين الكرتين
                      mainAxisSpacing: 12, // المسافة العمودية بين السطور
                      // 💡 النسبة بين العرض والارتفاع (childAspectRatio)
                      // العرض / الارتفاع -> إذا كان 1 يكون الكرت مربعاً تماماً
                      // إذا كان 0.75 أو 0.8 يصبح الكرت مستطيلاً عمودياً أنيقاً يتسع لـ (صورة، اسم البيتزا، السعر، وزر الإضافة)
                      childAspectRatio: 0.8,
                    ),

                    itemCount: cards.length, // عدد المنتجات
                    itemBuilder: (context, index) {
                      return Container(
                        // 💡 تخلصنا من الـ width والـ height اليدوية لأن الـ Grid تكفل بها عبر childAspectRatio
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(child: Text("Card Pizza")),
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
