import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_image.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_notification/notification_Model.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:app_owner/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';

class Notification_O_View extends StatelessWidget {
  final Notification_Model notification;
  const Notification_O_View({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final order = notification.order;

    return Scaffold(
      appBar: Widget_appBar(context, title: notification.title),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage_background(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.heightPct(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: context.heightPct(0.5),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.heightPct(5),
                      vertical: context.heightPct(4),
                    ),
                    child: WidgetTextRich(
                      context,
                      text: "timer: ",
                      content: notification.createdTime != null
                          ? Time_Calculate().showFullTime(
                              notification.createdTime!,
                            )
                          : "--",
                      colorContent: Colors.black,
                    ),
                  ),
                  WidgetTextRich(
                    context,
                    text: "Order: ",
                    content: order.orderId,
                    colorContent: Colors.black,
                  ),
                  WidgetTextRich(
                    context,
                    text: "Number: ",
                    content: order.client.number,
                    colorContent: Colors.black,
                  ),
                  WidgetTextRich(
                    context,
                    text: "Name: ",
                    content: order.client.name,
                    colorContent: Colors.black,
                  ),

                  WidgetTextRich(
                    context,
                    text: "Price: ",
                    content: "${notification.price} Da",
                    colorContent: const Color.fromARGB(255, 252, 147, 0),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(3),
                    ),
                    child: DashedLineDivider(
                      height: 3,
                      dashWidth: 20,
                      dashSpace: 15,
                      color: ColorApp_Icon_border.bottonbrown,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.heightPct(3),
                    ),
                    child: Text(
                      notification.description,
                      style: TextStyle(fontSize: context.heightPct(2.5)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget WidgetTextRich(
  BuildContext context, {
  required String text,
  required String content,
  required Color colorContent,
}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: text,
          style: TextStyle(
            fontSize: context.heightPct(2.5),
            fontFamily: "InterBold",
          ),
        ),
        TextSpan(
          text: content,
          style: TextStyle(
            fontSize: context.heightPct(2.5),
            color: colorContent,
          ),
        ),
      ],
    ),
  );
}
