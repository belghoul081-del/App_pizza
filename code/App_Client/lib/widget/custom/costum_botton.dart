import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Widget_botton(
  BuildContext context, {
  required String text,
  required VoidCallback onPressed,
  required double height,
  required double width,
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
          style: TextStyle(color: textColor, fontSize: context.heightPct(3)),
        ),
      ),
    ),
  );
}
