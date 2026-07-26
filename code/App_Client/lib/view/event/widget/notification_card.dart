import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_notification/notification_Model.dart';
import 'package:app_pizza_client/provider/event/time.dart';
import 'package:flutter/material.dart';

class Widget_Notification_Card extends StatelessWidget {
  final Notification_Model notification;
  const Widget_Notification_Card({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    String textStatus() {
      if (notification.order.status == "Done") {
        return "order has been prepared";
      }
      if (notification.order.status == "Delivery") {
        return "the order is way to you.";
      } else {
        return "order has been delivered";
      }
    }

    final bool isNetwork = notification.image.startsWith('http');

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
            width: context.heightPct(7),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              child: isNetwork
                  ? Image.network(notification.image, fit: BoxFit.cover)
                  : Image.asset(notification.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: context.widthPct(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: context.heightPct(2.5),
                      fontFamily: "InriaSerif",
                    ),
                  ),
                  Text(
                    textStatus(),
                    style: TextStyle(fontSize: context.heightPct(1.75)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: context.heightPct(1)),
            child: Text(
              notification.createdTime != null
                  ? Time_Calculate().getTimeAgo(notification.createdTime!)
                  : "--",
              style: TextStyle(fontSize: context.heightPct(2)),
            ),
          ),
        ],
      ),
    );
  }
}
