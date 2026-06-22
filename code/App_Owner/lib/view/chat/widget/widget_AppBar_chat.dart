import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

AppBar Widget_appBar_chat(BuildContext context) {
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
    title: Padding(
      padding: EdgeInsets.only(left: context.heightPct(9)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "chat",
              style: TextStyle(
                fontSize: context.heightPct(5),
                fontFamily: "InriaSerif",
                color: ColorApp_Icon_border.bottonbrown,
              ),
            ),
            SizedBox(width: context.widthPct(3)),
            IconButton(
              icon: Icon(Icons.call, color: ColorApp_Botton.bottonOrange),
              iconSize: context.heightPct(5),

              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.headset_mic_outlined,
                color: ColorApp_Botton.bottonOrange,
              ),
              iconSize: context.heightPct(5),

              onPressed: () {},
            ),
          ],
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
