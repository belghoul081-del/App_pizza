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

  String getChatMessageTime(DateTime createdTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(
      createdTime.year,
      createdTime.month,
      createdTime.day,
    );
    final differenceInDays = today.difference(messageDay).inDays;

    final String hh = createdTime.hour.toString().padLeft(2, '0');
    final String mm = createdTime.minute.toString().padLeft(2, '0');

    if (differenceInDays == 0) {
      // نفس اليوم: تظهر الساعة فقط
      return "$hh:$mm";
    } else if (differenceInDays == 1) {
      // البارحة
      return "yesterday $hh:$mm";
    } else {
      // أقدم من يومين: التاريخ الكامل (يوم/شهر/سنة)
      final String dd = createdTime.day.toString().padLeft(2, '0');
      final String moM = createdTime.month.toString().padLeft(2, '0');
      return "$dd/$moM/${createdTime.year}";
    }
  }

}
