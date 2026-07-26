import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_notification/notification_Model.dart';
import 'package:app_pizza_client/provider/event/time.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_client/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';

class Notification_O_View extends StatefulWidget {
  final Notification_Model notification;
  const Notification_O_View({super.key, required this.notification});

  @override
  State<Notification_O_View> createState() => _Notification_O_ViewState();
}

class _Notification_O_ViewState extends State<Notification_O_View> {
  @override
  Widget build(BuildContext context) {
    final notification = widget.notification;
    final location = notification.order.location;
    final String locationLabel = location.isSet
        ? "${location.lat.toStringAsFixed(5)}, ${location.lng.toStringAsFixed(5)}"
        : "undefined";

    return Scaffold(
      appBar: Widget_appBar(context, title: "Order"),
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
                    content: notification.title,
                    colorContent: Colors.black,
                  ),
                  WidgetTextRich(
                    context,
                    text: "Status: ",
                    content: notification.order.status.name,
                    colorContent: Colors.black,
                  ),
                  WidgetTextRich(
                    context,
                    text: "Location: ",
                    content: locationLabel,
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
