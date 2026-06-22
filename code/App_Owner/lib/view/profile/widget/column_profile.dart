import 'package:app_pizza_owner/models/admin/Admin_Model.dart';
import 'package:app_pizza_owner/view/profile/widget/bottonOFOpenORClose.dart';
import 'package:app_pizza_owner/view/profile/widget/widget_TextInfo.dart';
import 'package:app_pizza_owner/view/profile/widget/widget_button_logout.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_size.dart';

Widget Widget_profile(BuildContext context, Admin_Model clientInf) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: context.heightPct(1),
          left: context.heightPct(33),
        ),
        child: MaterialButton(
          height: context.heightPct(5),
          onPressed: () {},
          child: Icon(Icons.settings, size: context.heightPct(6)),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: context.heightPct(7),
          left: context.heightPct(2),
          right: context.heightPct(2),
        ),
        child: Column(
          children: [
            Text(
              clientInf.name,
              style: TextStyle(
                fontSize: context.heightPct(5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text_info_profile(
              context,
              textInf: clientInf.number,
              icon: Icons.numbers,
            ),
            Text_info_profile(
              context,
              textInf: clientInf.number2,
              icon: Icons.numbers,
            ),
            Text_info_profile(
              context,
              textInf: clientInf.addres,
              icon: Icons.location_on,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: context.heightPct(2),
                top: context.heightPct(1),
              ),
              child: Row(
                children: [
                  SwitchOpenORClose(),
                  Padding(
                    padding: EdgeInsets.only(left: context.heightPct(5)),
                    child: Text(
                      "Close Store",
                      style: TextStyle(
                        fontSize: context.heightPct(3),
                        fontFamily: "InterBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.heightPct(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Widget_botton_Blaklist(context)),
                  SizedBox(width: context.widthPct(0)),
                  Flexible(child: Widget_botton_Logout(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
