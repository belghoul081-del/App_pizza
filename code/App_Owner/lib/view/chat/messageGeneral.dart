import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/provider/chat/chat_Provider.dart';
import 'package:app_owner/view/chat/widget/card_client_chat.dart';
import 'package:app_owner/widget/appbare_widget/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat_page extends StatelessWidget {
  const Chat_page({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: Widget_appBar(context, title: 'chat'),
      body: chatProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : chatProvider.threads.isEmpty
          ? Center(
              child: Text(
                chatProvider.error ?? "There are no chats currently",
                style: TextStyle(fontSize: context.heightPct(2)),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: context.heightPct(2)),
              itemCount: chatProvider.threads.length,
              itemBuilder: (BuildContext context, int index) {
                return Card_Client_Chat(
                  context,
                  thread: chatProvider.threads[index],
                  
                );
              },
            ),
    );
  }
}
