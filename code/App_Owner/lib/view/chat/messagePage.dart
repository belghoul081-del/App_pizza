import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:app_pizza_owner/view/chat/widget/bottom_chat.dart';
import 'package:app_pizza_owner/view/chat/widget/widget_AppBar_chat.dart';
import 'package:flutter/material.dart';

class Message_page extends StatefulWidget {
  final Client_Model information_Client;
  const Message_page({super.key, required this.information_Client});

  @override
  State<Message_page> createState() => _Message_pageState();
}

class _Message_pageState extends State<Message_page> {
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
