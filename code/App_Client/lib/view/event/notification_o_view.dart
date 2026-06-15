import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/models/model_notification/notification_Model.dart';
import 'package:app_pizza_client/provider/cart/cart_Provider.dart';
import 'package:app_pizza_client/provider/event/time.dart';
import 'package:app_pizza_client/view/profile/account_view.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:app_pizza_client/widget/custom/costum_bar.dart';
import 'package:flutter/material.dart';

class Notification_O_View extends StatelessWidget {
  final Notification_Model notification;
  const Notification_O_View({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      "timer: ${Time_Calculate().showFullTime(notification.createdTime)}",
                      style: TextStyle(fontSize: context.heightPct(2.5)),
                    ),
                  ),
                  Text(
                    "Orger:1000D293RR",
                    style: TextStyle(fontSize: context.heightPct(2.5)),
                  ),
                  Text(
                    "Name: ${Client_Model().name}",
                    style: TextStyle(fontSize: context.heightPct(2.5)),
                  ),
                  Text(
                    "Location: Dalas-100-b2",
                    style: TextStyle(fontSize: context.heightPct(2.5)),
                  ),
                  Text(
                    "Price: ${notification.price} Da",
                    style: TextStyle(
                      fontSize: context.heightPct(2.5),
                      color: ColorApp_Botton.bottonOrange,
                    ),
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
                      style: TextStyle(fontSize: context.heightPct(2)),
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
