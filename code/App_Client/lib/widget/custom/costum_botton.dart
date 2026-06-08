import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';

Widget Widget_botton(BuildContext context, {required String text,
 required final VoidCallback onPressed,required double height , required double width}) {
  return MaterialButton(
    onPressed: onPressed,
    child: Container(
      height: context.heightPct(height),
      width: context.widthPct(width),
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
