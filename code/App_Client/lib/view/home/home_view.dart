import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/view/cart/cart_is_empty_view.dart';
import 'package:app_pizza_client/view/home/announcement_home.dart';
import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:app_pizza_client/view/home/categories_home.dart';
import 'package:app_pizza_client/models/model_category/category_Model.dart';
import 'package:app_pizza_client/view/home/lo_noti_acc.dart';
import 'package:app_pizza_client/view/home/products/cards_home.dart';
import 'package:app_pizza_client/view/home/widget/categories_bar/favorit_category.dart';
import 'package:app_pizza_client/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:provider/provider.dart';

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
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
          if (cartProvider.carts.isEmpty) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => empty_Order_Page()));
          } else {
            Navigator.of(context).pushNamed("Cart");
          }
        } else if (value == 2) {
          Navigator.of(context).pushNamed("Chat");
        }
      }, quantity: cartProvider.carts.length),
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
              child: CustomScrollView(
                slivers: [
                  ///هذه التي تتحرك
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        /// bar
                        Bar_Location_Notificaion_Bccount(context: context),

                        /// announcement
                        Announcement_home(totalBar: _totalBarcounter),
                      ],
                    ),
                  ),

                  /// لا تتجرك
                  SliverAppBar(
                    shadowColor: Colors.black,
                    floating: false,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    toolbarHeight: context.heightPct(10.2),
                    titleSpacing: 0,
                    pinned: true,
                    backgroundColor: ColorApp_Background.backgroundcolor,
                    surfaceTintColor: ColorApp_Background.backgroundcolor,
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// categories
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.heightPct(1.5),
                            bottom: context.heightPct(1.5),
                          ),
                          child: categories(
                            context: context,
                            selectedIndex: _selectedCategoryIndex,
                            onCategorySelected: (index) {
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                            },
                          ),
                        ),

                        DashedLineDivider(
                          height: context.heightPct(0.2),
                          dashWidth: context.heightPct(3.5),
                          dashSpace: context.heightPct(2),
                          color: ColorApp_Icon_border.bottonbrown,
                        ),
                      ],
                    ),
                  ),

                  /// cards
                  SliverPadding(
                    padding: EdgeInsets.zero,
                    sliver: SliverToBoxAdapter(
                      child: Products_cards_home(
                        selectedCategory: _selectedCategoryIndex == -1
                            ? "favorit"
                            : Category_Data
                                  .categories[_selectedCategoryIndex]
                                  .categories,
                      ),
                    ),
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
