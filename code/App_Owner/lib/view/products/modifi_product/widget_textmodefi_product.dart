import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget Text_show_Product({
  required BuildContext context,
  required String title,
  required String item,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.heightPct(2),
      vertical: context.heightPct(0.5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// text :
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
              TextSpan(
                text: item,

                style: TextStyle(
                  fontSize: item.length < 16
                      ? context.heightPct(3)
                      : context.heightPct(2),
                  fontFamily: "InterBold",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        modifi__Button_Modifi(context, onPressed: onPressed),
      ],
    ),
  );
}

Widget modifi__Button_Modifi(
  BuildContext context, {
  required VoidCallback onPressed,
}) {
  return Container(
    height: context.heightPct(4),
    width: context.heightPct(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      color: ColorApp_Background.appbarecolor,
    ),

    child: IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.edit_outlined,
        size: context.heightPct(3),
        color: ColorApp_Icon_border.bottonbrown,
      ),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
    ),
  );
}
