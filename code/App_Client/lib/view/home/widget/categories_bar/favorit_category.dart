import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget card_category_Favorit({
  required BuildContext context,
  required bool favorit,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: favorit
          ?ColorApp_Botton.bottonOrange 
          :ColorApp_Background.backgroundcolorII ,
      border: BoxBorder.all(color: ColorApp_Botton.bottonOrange),
    ),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(0.2)),
      child: Icon(
        Icons.favorite,
        color: ColorApp_Icon_border.bottonbrown,
        size: context.heightPct(5),
      ),
    ),
  );
}
