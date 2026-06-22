import 'package:app_pizza_owner/models/model_notification/notification_Model.dart';
import 'package:flutter/material.dart';

class Time_Calculate with ChangeNotifier {
  String getTimeAgo(DateTime createdTime) {
    final now = DateTime.now();
    final difference = now.difference(createdTime);
    if (difference.inSeconds < 60) {
      return "now";
    }
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min";
    }
    if (difference.inHours < 24) {
      return "${difference.inHours} h";
    }
    if (difference.inDays < 7) {
      return "${difference.inDays} days";
    }
    return "week";
  }

  String showFullTime(DateTime createdTime) {
    return "${createdTime.day}-${createdTime.month}-${createdTime.year} / ${createdTime.hour}:${createdTime.minute}";
  }

  static List<Notification_Model> getActiveNotification() {
    return Notification_Data.notification.where((n) {
      return DateTime.now().difference(n.createdTime).inDays > 7;
    }).toList();
  }
}
