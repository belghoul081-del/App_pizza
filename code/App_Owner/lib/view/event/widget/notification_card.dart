import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_notification/notification_Model.dart';
import 'package:app_pizza_owner/provider/event/time.dart';
import 'package:flutter/material.dart';

class Widget_Notification_Card extends StatelessWidget {
  final Notification_Model notification;
  const Widget_Notification_Card({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: context.heightPct(10),
      decoration: BoxDecoration(
        color: notification.isRead
            ? ColorApp_Background.backgroundcolorII
            : ColorApp_Botton.bottonOrange,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            spreadRadius: 0.1,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          notification.isRead
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.heightPct(1),
                  ),
                  child: SizedBox(
                    height: context.heightPct(1.5),
                    width: context.heightPct(1.5),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.heightPct(1),
                  ),
                  child: Container(
                    height: context.heightPct(1.5),
                    width: context.heightPct(1.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),

          Container(
            height: context.heightPct(7),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              child: Image.asset(notification.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: context.widthPct(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: context.heightPct(3.5),
                    fontFamily: "SemiBold",
                  ),
                ),
                Text(
                  notification.description,
                  style: TextStyle(fontSize: context.heightPct(2)),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Text(
            Time_Calculate().getTimeAgo(notification.createdTime),
            style: TextStyle(fontSize: context.heightPct(2)),
          ),
        ],
      ),
    );
  }
}
