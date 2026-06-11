import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/widget/custom/costum_bar.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:flutter/material.dart';

Widget widget_BottomNavigationBar(BuildContext context,{required double priceTotal}) {
  return Container(
    height: context.heightPct(20),
    width: double.infinity,
    decoration: BoxDecoration(
      color: ColorApp_Background.backgroundcolor,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: const Offset(0, -1),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.heightPct(4),
                vertical: context.heightPct(1),
              ),
              child: Text(
                "${priceTotal} Da",
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "SemiBold",
                ),
              ),
            ),
          ],
        ),

        DashedLineDivider(
          height: context.heightPct(0.2),
          dashWidth: context.heightPct(2),
          dashSpace: context.heightPct(1),
          color: ColorApp_Icon_border.bottonbrown,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.heightPct(2)),
          child: Widget_botton(
            context,
            text: "Checkout",
            onPressed: () {},
            height: 8,
            width: 90,
          ),
        ),
        
      ],
    ),
  );
}
