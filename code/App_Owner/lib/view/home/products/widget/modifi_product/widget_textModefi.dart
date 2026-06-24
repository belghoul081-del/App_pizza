import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Text_Modefie_Product({
  required BuildContext context,
  required TextEditingController controller,
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    height: context.heightPct(5.5),
    width: context.widthPct(90),
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: ColorApp_Background.chate_massege,
      border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: TextFormField(
      controller: controller,
      maxLength: 24,
      obscureText: false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        border: InputBorder.none,
      ),
      style: TextStyle(
        fontSize: context.heightPct(2.5),
        fontFamily: "InterBold",
        color: Colors.black,
      ),
    ),
  );
}
