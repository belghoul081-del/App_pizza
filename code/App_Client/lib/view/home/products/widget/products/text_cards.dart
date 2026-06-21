import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget widget_Title_Cards(BuildContext context, {required String text,required Color color}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: context.heightPct(2),
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget widget_Price_Cards(BuildContext context, int price) {
  return Text(
    "${price} Da",
    style: TextStyle(
      color: ColorApp_Text.textblack,
      fontSize: context.heightPct(2),
      fontWeight: FontWeight.bold,
      fontFamily: "SemiBold",
    ),
  );
}
