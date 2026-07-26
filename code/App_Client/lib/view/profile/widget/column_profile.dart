import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/view/profile/widget/widget_TextInfo.dart';
import 'package:app_pizza_client/view/settings/settings_view.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_size.dart';

Widget Widget_profile(
  BuildContext context, {
  required Function() onPressed,
  required Client_Model clientInf,
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
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Settings_Page()),
            );
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
              clientInf.name,
              style: TextStyle(
                fontSize: context.heightPct(5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text_info_profile(context, clientInf),
            Padding(
              padding: EdgeInsets.only(top: context.heightPct(25)),
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
  );
}
