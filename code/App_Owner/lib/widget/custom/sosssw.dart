import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';

void showFeatureUnavailableBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => Container(
      width: context.widthPct(90),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
      ),
      padding: EdgeInsets.all(context.heightPct(2)),
      decoration: BoxDecoration(
        color: ColorApp_Background.appbarecolor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        border: Border.all(
          color: ColorApp_Icon_border.bottonbrown,
          width: context.heightPct(0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // مقبض صغير للسحب
          Container(
            width: context.widthPct(15),
            height: context.heightPct(0.7),
            decoration: BoxDecoration(
              color: ColorApp_Icon_border.bottonbrown.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: context.heightPct(2)),
          Icon(
            Icons.construction,
            size: context.heightPct(8),
            color: ColorApp_Botton.bottonOrange,
          ),
          SizedBox(height: context.heightPct(1.5)),
          Text(
            "هذه الميزة غير متاحة حاليًا",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.heightPct(2.5),
              fontFamily: "InterBold",
              color: ColorApp_Text.textbrown,
            ),
          ),
          SizedBox(height: context.heightPct(1)),
          Text(
            "سنقوم بتفعيلها قريبًا، شكرًا لتفهمك",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.heightPct(1.8),
              fontFamily: "Inter",
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: context.heightPct(3)),
          // زر إغلاق اختياري بنفس ستايل Dialogbotton_Confirm
          MaterialButton(
            onPressed: () => Navigator.pop(sheetContext),
            padding: EdgeInsets.zero,
            child: Container(
              height: context.heightPct(7),
              width: context.widthPct(40),
              decoration: BoxDecoration(
                color: ColorApp_Botton.bottonOrange,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "حسنًا",
                  style: TextStyle(
                    color: ColorApp_Text.textbrown,
                    fontSize: context.heightPct(2.5),
                    fontFamily: "InterBold",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.heightPct(1)),
        ],
      ),
    ),
  );
}