import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

AppBar Widget_appBar(BuildContext context, {required String title}) {
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
        Navigator.of(context).pop();
      },
    ),
    toolbarHeight: context.heightPct(10),
    title: Center(
      child: Text(
        title,
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
  );
}
