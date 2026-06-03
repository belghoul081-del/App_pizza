import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';

Widget botton_login(BuildContext context, String text,
  final VoidCallback onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    child: Container(
      height: context.heightPct(7),
      width: context.widthPct(60),
      decoration: BoxDecoration(
        color: ColorApp_Botton.bottonOrange,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: ColorApp_Text.textbrown,
            fontSize: context.heightPct(3),
          ),
        ),
      ),
    ),
  );
}
