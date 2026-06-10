import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Widget_Images_Cards(BuildContext context, {required String image,required double size}) {
  return Container(
    height: context.heightPct(size),
    decoration: BoxDecoration(
      color: ColorApp_Icon_border.bottonbrown,
      shape: BoxShape.circle,
      border: Border.all(color: ColorApp_Icon_border.bottonbrown)
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Image.asset(image, fit: BoxFit.cover),
    ),
  );
}
