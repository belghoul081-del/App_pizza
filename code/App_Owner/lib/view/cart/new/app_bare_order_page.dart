import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/view/cart/new/general_cart_card.dart';
import 'package:flutter/material.dart';

AppBar AppBar_Order_Page(BuildContext context, {required String order_ID , required String image}) {
  return AppBar(
    backgroundColor: ColorApp_Background.backgroundcolor,

    /// icon
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: ColorApp_Icon_border.bottonbrown,
      ),
      iconSize: context.heightPct(6),

      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ),
    toolbarHeight: context.heightPct(10),
    title: Center(
      child: Row(
        children: [
          Text(
            "order :  ${order_ID}",
            style: TextStyle(
              fontSize: context.heightPct(2.9),
              fontFamily: "InriaSerif",
              color: ColorApp_Icon_border.bottonbrown,
            ),
          ),
          SizedBox(width: context.heightPct(1)),
          buildOrderIconButton(
            context,
            image,
            () {},
          ),
        ],
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
  );
}
