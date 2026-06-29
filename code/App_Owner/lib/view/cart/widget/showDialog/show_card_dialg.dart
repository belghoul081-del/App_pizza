import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/admin/Admin_Model.dart';
import 'package:flutter/material.dart';

Dialog costumAlertDialog(BuildContext context, {required int priceTotal}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: context.widthPct(90),
      padding: EdgeInsets.all(context.heightPct(1)),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorApp_Icon_border.bottonbrown,
          width: context.heightPct(0.3),
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: ColorApp_Background.appbarecolor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.heightPct(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${DateTime.now().hour}:${DateTime.now().minute}"),
                Text(
                  "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.heightPct(3)),
            child: WidgetTextRich_Dialog(
              context,
              text: "Orger: ",
              content: "1000D293RR",
            ),
          ),
          WidgetTextRich_Dialog(
            context,
            text: "Name: ",
            content: "${Admin_Model().name}",
          ),
          WidgetTextRich_Dialog(
            context,
            text: "Location: ",
            content: "Dalas-100-b2",
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.heightPct(7),
              top: context.heightPct(2),
              bottom: context.heightPct(1),
            ),
            child: WidgetTextRich_Dialog(
              context,
              text: "Price: ",
              content: "${priceTotal} Da",
            ),
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // هذا سيوفر التباعد للأطراف
            children: [
              // لا نستخدم Expanded هنا، بل نستخدم عرضاً محدداً للزر
              SizedBox(
                width: context.widthPct(35),
                child: Dialogbotton_Location(context),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(context),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget Dialogbotton_Location(BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Container(
      height: context.heightPct(5),
      width: context.widthPct(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: ColorApp_Icon_border.bottonbrown),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: ColorApp_Icon_border.bottonbrown,
            size: context.heightPct(4),
          ),
          Text(
            "Location",
            style: TextStyle(
              color: ColorApp_Text.textbrown,
              fontSize: context.heightPct(2.5),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget Dialogbotton_Confirm(BuildContext context) {
  return MaterialButton(
    onPressed: () {},
    padding: EdgeInsets.zero,
    child: Container(
      height: context.heightPct(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorApp_Botton.bottonOrange,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          "Confirm",
          style: TextStyle(
            color: ColorApp_Text.textbrown,
            fontSize: context.heightPct(2.5),
          ),
        ),
      ),
    ),
  );
}

Widget WidgetTextRich_Dialog(
  BuildContext context, {
  required String text,
  required String content,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.heightPct(3),
      vertical: context.heightPct(0.5),
    ),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: context.heightPct(2),
              fontFamily: "InterBold",
              color: ColorApp_Botton.bottonOrange,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
              fontSize: context.heightPct(2),
              fontFamily: "InterBold",
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
