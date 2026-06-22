import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget card_category_I({
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
      color: ColorApp_Botton.bottonOrange,
      border: BoxBorder.all(color: ColorApp_Botton.bottonOrange),

      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(context.heightPct(0)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorApp_Background.backgroundcolorII,
            border: Border.all(color: ColorApp_Botton.bottonOrange, width: 0),
          ),
          child: Image.asset(
            category.imagePath,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.fastfood),
          ),
        ),
        Text(
          category.name,
          style: TextStyle(
            fontFamily: "SemiBold",
            fontWeight: FontWeight.w900,
            fontSize: context.heightPct(2),
            color: ColorApp_Text.textbrown,
          ),
        ),
      ],
    ),
  );
}
