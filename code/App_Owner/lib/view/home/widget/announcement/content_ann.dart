import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_announcement/announcement_Model.dart';
import 'package:flutter/material.dart';

Widget Content(
  BuildContext context, {
  required int barIndex,
  required int totalBar,
  required PageController controller,
}) {
  return Container(
    child: PageView.builder(
      controller: controller,
      itemCount: totalBar,
      itemBuilder: (context, index) {
        final announcement = Announcement_Data.announcement[index];
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                announcement.image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: context.heightPct(1),
              right: context.heightPct(1),
              child: Container(
                height: context.heightPct(4),
                width: context.widthPct(30),
                decoration: BoxDecoration(
                  color: ColorApp_Botton.bottonOrange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Text(
                    "Order now",
                    style: TextStyle(
                      fontFamily: "SemiBold",
                      color: ColorApp_Text.textblack,
                      fontSize: context.heightPct(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
