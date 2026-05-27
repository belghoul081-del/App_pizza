import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

class Widget_StarePage extends StatelessWidget {
  final String text;
  final String image;

  const Widget_StarePage({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.heightPct(7)),
        AppImage_Logo(size: context.heightPct(30), image: "$image"),
        SizedBox(height: 0),
        Text(
          "$text",
          style: TextStyle(
            fontFamily: "IosevkaCharon",
            color: ColorApp_Text.textbrown,
            fontSize: context.heightPct(7.25),
            letterSpacing: context.heightPct(0.2),
          ),
        ),
      ],
    );
  }
}
