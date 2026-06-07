import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Widget_Images_Cards(BuildContext context,{required String image}) {
  return Container(
    height: context.heightPct(15),
    decoration: BoxDecoration(
      color: ColorApp_Icon_border.bottonbrown,
      shape: BoxShape.circle,
    ),
    child: Image.asset(image,fit: BoxFit.cover,),
  );
}
