import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/models/model_notification/notification_Model.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/view/event/notification_o_view.dart';
import 'package:app_owner/view/event/widget/notification_card.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notification_Page extends StatelessWidget {
  const Notification_Page({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    final notifications = orderProvider.allOrders
        .map((order) => Notification_Model.fromOrder(order))
        .toList();

    return Scaffold(
      appBar: Widget_appBar(context, title: 'notification'),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
          ? Center(
              child: Text(
                orderProvider.error ?? "No notifications currently available",
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
                      // (يحدّث لون الكرت تلقائيًا)
                      Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      ).markOrderAsRead(notification.orderId);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
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
