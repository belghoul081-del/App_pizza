import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/view/chat/widget/bottom_chat.dart';
import 'package:app_pizza_owner/view/chat/widget/widget_AppBar_chat.dart';
import 'package:flutter/material.dart';

class Chat_page extends StatefulWidget {
  const Chat_page({super.key});

  @override
  State<Chat_page> createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: Widget_appBar_chat(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Container(), Bottom_chat(context)],
        ),
      ),
    );
  }
}
