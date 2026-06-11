import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget widget_Botton_Cards(
  BuildContext context, {
  required Color color,
  required IconData icon,
  required  VoidCallback onPress
}) {
  return Container(
    height: context.heightPct(4),
    width: context.heightPct(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: color,
    ),
    child: Center(
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        icon: Icon(
          icon,
          color: ColorApp_Icon_border.bottontblack,
        ),
      ),
    ),
  );
}
