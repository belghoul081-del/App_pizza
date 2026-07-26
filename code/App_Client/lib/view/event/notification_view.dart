import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/provider/order/order_Provider.dart';
import 'package:app_pizza_client/view/event/notification_o_view.dart';
import 'package:app_pizza_client/view/event/widget/notification_card.dart';
import 'package:app_pizza_client/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notification_Page extends StatelessWidget {
  const Notification_Page({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    final notifications = orderProvider.notifications;

    return Scaffold(
      appBar: Widget_appBar(context, title: 'notification'),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
          ? Center(
              child: Text(
                orderProvider.error ?? "No notifications currently available ${orderProvider.error}",
                style: TextStyle(fontSize: context.heightPct(2)),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: context.heightPct(5)),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.heightPct(2),
                    vertical: context.heightPct(1),
                  ),
                  child: InkWell(
                    onTap: () {
                      Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      ).markNotificationAsRead(notification.orderId, notification.status);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              Notification_O_View(notification: notification),
                        ),
                      );
                    },
                    child: Widget_Notification_Card(notification: notification),
                  ),
                );
              },
            ),
    );
  }
}
