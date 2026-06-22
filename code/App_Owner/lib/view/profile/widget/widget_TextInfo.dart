import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/admin/Admin_Model.dart';
import 'package:flutter/material.dart';

Widget Text_info_profile(
  BuildContext context, {
  required String textInf,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: context.heightPct(0.5)),
    child: Container(
      height: context.heightPct(7),
      width: context.widthPct(100),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Padding(
            padding: EdgeInsets.only(left: context.heightPct(1)),
            child: Icon(
              icon,
              color: ColorApp_Botton.bottonOrange,
              size: context.heightPct(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: context.heightPct(3)),
            child: Text(
              textInf,
              style: TextStyle(
                fontSize: context.heightPct(3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
