import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Bottom_chat(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.widthPct(5),
      vertical: context.heightPct(1),
    ),
    child: Container(
      height: context.heightPct(7),
      width: context.widthPct(80),
      decoration: BoxDecoration(
        color: ColorApp_Background.spaceofwrite_info_massege,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat,
              color: ColorApp_Icon_border.bottonbrown,
              size: context.heightPct(5),
            ),
          ),

          Expanded(
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Messege ...",
                border: InputBorder.none,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: ColorApp_Icon_border.bottonbrown,
              size: context.heightPct(5),
            ),
          ),
        ],
      ),
    ),
  );
}
