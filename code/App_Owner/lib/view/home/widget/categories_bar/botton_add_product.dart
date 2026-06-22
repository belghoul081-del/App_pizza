import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Button_ADD_product({required BuildContext context}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: ColorApp_Background.appbarecolor,
      border: BoxBorder.all(color: ColorApp_Icon_border.bottonbrown),
    ),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(0.2)),
      child: Icon(
        Icons.add,
        color: ColorApp_Icon_border.bottonbrown,
        size: context.heightPct(5),
      ),
    ),
  );
}
