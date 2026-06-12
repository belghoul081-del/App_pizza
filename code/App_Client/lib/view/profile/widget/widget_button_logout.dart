import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';

Widget Widget_botton_Logout(BuildContext context) {
  return MaterialButton(
    onPressed: () {},
    child: Container(
      height: context.heightPct(8),
      width: context.widthPct(60),
      decoration: BoxDecoration(
        color: const Color(0xFFD60000),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontSize: context.heightPct(3)),
        ),
      ),
    ),
  );
}
