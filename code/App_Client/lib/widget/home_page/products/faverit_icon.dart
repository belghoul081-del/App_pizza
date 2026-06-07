import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Widget_Faverit_Icon(BuildContext context) {
  return Positioned(
    right: 0,
    top: 0,
    child: IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      iconSize: context.heightPct(3.5),
      onPressed: () {},
      icon: Icon(
        Icons.favorite_border,
        color: ColorApp_Icon_border.bottonbrown,
      ),
    ),
  );
}
