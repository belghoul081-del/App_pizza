import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget card_category_II({
  required BuildContext context,
  required category,
  required isSelected,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: ColorApp_Background.backgroundcolorII,
      border: BoxBorder.all(color: ColorApp_Botton.bottonOrange),
    ),
    child: Container(
      padding: EdgeInsets.all(context.heightPct(category.size)),
      child: Image.asset(
        category.imagePath,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.fastfood),
      ),
    ),
  );
}
