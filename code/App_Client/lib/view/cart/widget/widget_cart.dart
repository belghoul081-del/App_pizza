import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget widget_Card_Cart(BuildContext context) {
  return Center(
    child: Stack(
      children: [
        
        Container(
          height: context.heightPct(15),
          width: context.widthPct(80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.orange,
          ),
        ),
        Positioned(
          right: context.widthPct(70),
          child: Container(
            height: context.heightPct(15),
            width: context.heightPct(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
  );
}
