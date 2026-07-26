import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/provider/clients_Provider.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/view/analise_view.dart';
import 'package:app_owner/view/announcement/announcement_home.dart';
import 'package:app_owner/view/home/b_N_Bar_home.dart';
import 'package:app_owner/view/home/categories_home.dart';
import 'package:app_owner/models/model_category/category_Model.dart';
import 'package:app_owner/view/home/lo_noti_acc.dart';
import 'package:app_owner/view/home/widget/notif_op_cl_store.dart';
import 'package:app_owner/view/products/cards_home.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:provider/provider.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetdataProvider>(context, listen: false).LoadData_Admin();
            Provider.of<ClientsProvider>(context, listen: false).loadAllClients();

    });
  }

  int _currentIndex = 0;
  int _selectedCategoryIndex = 0;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final allOrders = orderProvider.allOrders;
    final int incomingOrdersCount = allOrders
        .where(
          (order) =>
              order.status.state == "waiting" || order.status.state == "Cook",
        )
        .length;

    double screenWidht = MediaQuery.of(context).size.width;

    return Consumer<GetdataProvider>(
      builder: (context, provider, child) {
        
        if (provider.isLoading) {
          return const CircularProgressIndicator();
        }
        if (provider.admin.isEmpty) {
          return const Text("ther is not  id or data");
        }
        final bool isOpen = provider.admin[0].isOpen;
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          floatingActionButton: SizedBox(
            height: context.heightPct(10),
            width: context.heightPct(10),
            child: FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: Colors.amber,
              onPressed: () {
                Navigator.of(context).pushNamed("Cart");
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: ColorApp_Background.appbarecolor,
                    size: context.heightPct(7.5),
                  ),
                  Positioned(
                    top: -context.heightPct(3),
                    left: 0,
                    right: -context.heightPct(7),
                    child: Container(
                      alignment: Alignment.center,
                      height: context.heightPct(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorApp_Background.appbarecolor,
                        border: Border.all(
                          color: ColorApp_Icon_border.bottonbrown,
                        ),
                      ),
                      child: Text(
                        "${incomingOrdersCount}",
                        style: TextStyle(
                          color: ColorApp_Text.textred,
                          fontFamily: "SemiBold",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar_home(
            context,
            _currentIndex,
            (index) {
              setState(() {
                if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeatureUnavailablePage(),
                      ),
                    );
                  
                } else if (index == 1) {
                  _currentIndex = 1;
                } else if (index == 2) {
                  Navigator.of(context).pushNamed("Chat");
                }
              });
            },
          ),
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
                            Bar_Location_Notificaion_Account(context: context  ),
                            isOpen ? SizedBox() : notif_op_cl_store(),

                            /// announcement
                            Announcement_home(),
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
                            selectedCategory: Category_Data
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
      },
    );
  }
}
