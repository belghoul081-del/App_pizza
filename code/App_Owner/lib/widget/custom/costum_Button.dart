import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_size.dart';

Widget Widget_botton(
  BuildContext context, {
  required String text,
  required VoidCallback onPressed,
  required double height ,
  required double width ,
  required Color backgroundColor,
  required Color textColor,
}) {
  return MaterialButton(
    onPressed: onPressed,
    child: Container(
      height: context.heightPct(height),
      width: context.widthPct(width),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor ,
            fontSize: context.heightPct(3),
          ),
        ),
      ),
    ),
  );
}
