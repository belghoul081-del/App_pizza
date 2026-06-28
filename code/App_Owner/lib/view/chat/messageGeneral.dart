import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/client/client_Model.dart';
import 'package:app_pizza_owner/view/chat/widget/bottom_chat.dart';
import 'package:app_pizza_owner/view/chat/widget/card_client_chat.dart';
import 'package:app_pizza_owner/view/chat/widget/widget_AppBar_chat.dart';
import 'package:app_pizza_owner/widget/appbare_widget/appBar_widget.dart';
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
      appBar: Widget_appBar(context, title: 'chat'),
      body: ListView.builder(
        padding: EdgeInsets.only(top: context.heightPct(2)),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Card_Client_Chat(context);
        },
      ),
    );
  }
}
