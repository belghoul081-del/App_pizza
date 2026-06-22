import 'dart:async';

import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/model_notification/notification_Model.dart';
import 'package:app_pizza_owner/view/event/notification_o_view.dart';
import 'package:app_pizza_owner/view/event/widget/notification_card.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';

class Notification_Page extends StatefulWidget {
  const Notification_Page({super.key});

  @override
  State<Notification_Page> createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widget_appBar(context, title: 'notification'),
      body: ListView.builder(
        padding: EdgeInsets.only(top: context.heightPct(5)),
        itemBuilder: (context, index) {
          final notification = Notification_Data.notification[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.heightPct(2),
              vertical: context.heightPct(1),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  Notification_Data.notification[index].isRead = true;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Notification_O_View(notification: notification),
                    ),
                  );
                });
                //Navigator.of(context).pushNamed("Home");
              },
              child: Widget_Notification_Card(notification: notification),
            ),
          );
        },
        itemCount: Notification_Data.notification.length,
      ),
    );
  }
}
