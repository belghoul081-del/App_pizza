import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/announcement/announce_provider.dart';
import 'package:app_owner/view/announcement/widget/bar_of_change.dart';
import 'package:app_owner/view/announcement/widget/content_ann.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class Announcement_home extends StatefulWidget {
  const Announcement_home({super.key});

  @override
  State<Announcement_home> createState() => _Announcement_homeState();
}

class _Announcement_homeState extends State<Announcement_home> {
  late PageController _barController;
  int _currentBarIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _barController = PageController(initialPage: 0);

    _barController.addListener(() {
      if (_barController.hasClients && _barController.page != null) {
        int next = _barController.page!.round();
        if (_currentBarIndex != next) {
          setState(() {
            _currentBarIndex = next;
          });
        }
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (!mounted) return;
      
      // جلب عدد العناصر الحالي من الـ Provider بدون الاستماع اللحظي داخل التايمر
      final provider = context.read<AnnouncementProvider>();
      int totalItems = provider.announcement.length + 1; // الإعلانات + زر الإضافة

      if (_barController.hasClients && totalItems > 1) {
        if (_currentBarIndex < totalItems - 1) {
          _currentBarIndex++;
        } else {
          _currentBarIndex = 0;
        }
        _barController.animateToPage(
          _currentBarIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnnouncementProvider>();
    final announcements = provider.announcement;
    
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    int totalItems = announcements.length + 1; // الإعلانات القادمة + بطاقة الزر

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.heightPct(0.2),
        horizontal: context.heightPct(2),
      ),
      height: context.heightPct(15),
      child: Column(
        children: [
          Expanded(
            child: Content(
              context,
              announcements: announcements,
              totalBar: totalItems,
              controller: _barController,
            ),
          ),
          bar_change_announcement(
            context,
            barIndex: _currentBarIndex,
            totalBar: totalItems,
            controller: _barController,
          ),
        ],
      ),
    );
  }
}
