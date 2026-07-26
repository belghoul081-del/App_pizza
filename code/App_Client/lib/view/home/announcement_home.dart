import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';
import 'package:app_pizza_client/view/home/widget/announcement/bar_of_change.dart';
import 'package:app_pizza_client/view/home/widget/announcement/content_ann.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Announcement_home extends StatefulWidget {
  final int totalBar;
    final List<Announcement_Model> items;
  Announcement_home({super.key, required this.totalBar, required this.items});

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
      if (_barController.hasClients) {
        if (_currentBarIndex < widget.totalBar - 1) {
          _currentBarIndex++;
        } else {
          _currentBarIndex = 0;
        }
        _barController.animateToPage(
          _currentBarIndex,
          duration: const Duration(
            milliseconds: 300,
          ), 
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
              barIndex: _currentBarIndex,
              totalBar: widget.totalBar,
              controller: _barController,
              items: widget.items,
            ),
          ),
          bar_change_announcement(
            context,
            barIndex: _currentBarIndex,
            totalBar: widget.totalBar,
            controller: _barController,
          ),
        ],
      ),
    );
  }
}
