import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/models/admin/admin_model.dart';
import 'package:app_owner/view/blacklist/blacklist_view.dart';
import 'package:app_owner/view/profile/widget/bottonOFOpenORClose.dart';
import 'package:app_owner/view/profile/widget/widget_TextInfo.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_size.dart';

Widget Widget_profile(
  BuildContext context, {
  required Function() onPressed,
  required Admin_Model adminInf,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: context.heightPct(1),
          left: context.heightPct(33),
        ),
        child: MaterialButton(
          height: context.heightPct(5),
          onPressed: () {
            Navigator.of(context).pushNamed("Settings");
          },
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
              adminInf.name,
              style: TextStyle(
                fontSize: context.heightPct(5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text_info_profile(
              context,
              textInf: adminInf.number,
              icon: Icons.numbers,
            ),
            Text_info_profile(
              context,
              textInf: adminInf.number2,
              icon: Icons.numbers,
            ),
            Text_info_profile(
              context,
              textInf: adminInf.addres,
              icon: Icons.location_on,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: context.heightPct(2),
                top: context.heightPct(1),
              ),
              child: Row(
                children: [
                  SwitchOpenORClose(isOpen: adminInf.isOpen),
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
                  Expanded(
                    child: Widget_botton(
                      context,
                      text: 'Black list',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Blacklist_Page(),
                          ),
                        );
                      },
                      height: 8,
                      width: 50,
                      backgroundColor: ColorApp_Icon_border.bottonbrown,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: context.widthPct(0)),
                  Flexible(
                    child: Widget_botton(
                      context,
                      text: 'Logout',
                      onPressed: onPressed,
                      height: 8,
                      width: 50,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
