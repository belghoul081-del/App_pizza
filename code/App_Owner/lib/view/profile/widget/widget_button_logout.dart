import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_size.dart';

Widget Widget_botton_Logout(BuildContext context) {
  return MaterialButton(
    onPressed: () {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil("Welcome", (Route<dynamic> route) => false);
    },
    child: Container(
      height: context.heightPct(8),
      width: context.widthPct(50),
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

Widget Widget_botton_Blaklist(BuildContext context) {
  return MaterialButton(
    onPressed: () {},
    child: Container(
      height: context.heightPct(8),
      width: context.widthPct(50),
      decoration: BoxDecoration(
        color: ColorApp_Icon_border.bottonbrown,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          "Black list",
          style: TextStyle(color: Colors.white, fontSize: context.heightPct(3)),
        ),
      ),
    ),
  );
}
