import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/order/location_Model.dart';
import 'package:app_owner/view/location/location_viewer_page.dart';
import 'package:flutter/material.dart';

Dialog costumAlertDialog(
  BuildContext context, {
  required VoidCallback onPresseddelete,
  required VoidCallback onPressedcancel,
}) {
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
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "delete order",
                style: TextStyle(
                  fontSize: context.heightPct(3),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textred,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "do you want delete order",
                style: TextStyle(
                  fontSize: context.heightPct(2),
                  fontFamily: "InterBold",
                  color: ColorApp_Text.textbrown,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPresseddelete,
                  name: "delete",
                  color: ColorApp_Text.textred,
                ),
              ),
              SizedBox(
                width: context.widthPct(30),
                child: Dialogbotton_Confirm(
                  context,
                  onPressed: onPressedcancel,
                  name: "cancel",
                  color: ColorApp_Botton.bottonOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget Dialogbotton_Location(
  BuildContext context, {
  required Location_Model location,
}) {
  final bool hasLocation = location.isSet;

  return MaterialButton(
    onPressed: !hasLocation
        ? null
        : () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LocationViewerPage(location: location),
              ),
            );
          },
    padding: EdgeInsets.zero,
    child: Container(
      height: context.heightPct(7),
      decoration: BoxDecoration(
        color: hasLocation ? const Color(0xFFFDE6C8) : Colors.grey.shade300,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          color: hasLocation ? ColorApp_Icon_border.bottonbrown : Colors.grey,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: hasLocation
                  ? ColorApp_Icon_border.bottonbrown
                  : Colors.grey,
              size: context.heightPct(5),
            ),
            Text(
              hasLocation ? "View Location" : "No Location",
              style: TextStyle(
                color: ColorApp_Text.textbrown,
                fontSize: context.heightPct(2.2),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget Dialogbotton_Confirm(
  BuildContext context, {
  required VoidCallback onPressed,
  required String name,
  required Color color,
}) {
  return MaterialButton(
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    child: Container(
      height: context.heightPct(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: ColorApp_Text.textbrown,
            fontSize: context.heightPct(2.5),
          ),
        ),
      ),
    ),
  );
}
