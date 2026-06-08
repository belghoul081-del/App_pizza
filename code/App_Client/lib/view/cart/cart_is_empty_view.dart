import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/view/home/b_N_Bar_home.dart';
import 'package:app_pizza_client/widget/appbare_widget/sliverAppBar_widget.dart';
import 'package:app_pizza_client/view/cart/widget/widget_bottomNavigationBar.dart';
import 'package:app_pizza_client/view/cart/widget/widget_cart.dart';
import 'package:app_pizza_client/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class empty_Order_Page extends StatefulWidget {
  const empty_Order_Page({super.key});

  @override
  State<empty_Order_Page> createState() => _empty_Order_PageState();
}

class _empty_Order_PageState extends State<empty_Order_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp_Background.backgroundcolor,

        /// icon
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorApp_Icon_border.bottonbrown,
          ),
          iconSize: context.heightPct(6),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: context.heightPct(10),
        title: Center(
          child: Text(
            "Cart Details",
            style: TextStyle(
              fontSize: context.heightPct(5),
              fontFamily: "InriaSerif",
              color: ColorApp_Icon_border.bottonbrown,
            ),
          ),
        ),

        /// line
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // سماكة الخط
          child: Container(
            color: ColorApp_Icon_border.bottonbrown,
            height: context.heightPct(0.3),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.heightPct(5)),
            child: Text(
              "Your basket is empty , Order now!",
              style: TextStyle(
                color: Color(0xFF616161),
                fontSize: context.heightPct(2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
            child: DashedLineDivider(
              height: context.heightPct(0.2),
              dashWidth: context.heightPct(2),
              dashSpace: context.heightPct(1),
              color: Color(0xFF616161),
            ),
          ),
          // SvgPicture.asset(
          //   'assets/icons/sad-face.svg',
          //   height: context.heightPct(40),
          //   colorFilter: const ColorFilter.mode(
          //     Color(0xFF616161),
          //     BlendMode.srcIn,
          //   ),
          // ),
        ],
      ),
    );
  }
}
