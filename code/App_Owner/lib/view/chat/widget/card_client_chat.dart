import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/firestore/service/chats_service.dart';
import 'package:app_owner/models/model_chat/chat_Model.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/view/chat/messagePage.dart';
import 'package:flutter/material.dart';

Widget Card_Client_Chat(
  BuildContext context, {
  required ChatThread_Model thread,
}) {
  final bool isNetwork = thread.clientImage.startsWith('http');
  return InkWell(
    onTap: () {
      ChatsFirestoreService().markChatAsRead(thread.chatId);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Message_page(
            chatId: thread.chatId,
            clientName: thread.clientName,
            clientImage: thread.clientImage,
            clientNumber: thread.clientNumber,
          ),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.heightPct(1),
        horizontal: context.heightPct(2),
      ),
      child: Container(
        height: context.heightPct(9),
        width: context.widthPct(80),
        decoration: BoxDecoration(
          color: thread.unreadByOwner
              ? ColorApp_Botton.bottonOrange.withOpacity(0.25)
              : const Color.fromARGB(255, 252, 241, 227),
          border: Border.all(color: ColorApp_Icon_border.bottonbrown),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: context.heightPct(0.5),
                right: context.heightPct(2),
              ),
              child: Container(
                height: context.heightPct(7.5),
                width: context.heightPct(7.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp_Icon_border.bottonbrown),
                  image: DecorationImage(
                    image: isNetwork
                        ? NetworkImage(thread.clientImage) as ImageProvider
                        : AssetImage(thread.clientImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.heightPct(1),
                  top: context.heightPct(0.5),
                  bottom: context.heightPct(0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.clientName,
                      style: TextStyle(
                        fontFamily: "InterBold",
                        fontSize: context.heightPct(2),
                      ),
                    ),
                    Text(
                      thread.lastMessage.isEmpty
                          ?"No messages yet"
                          : thread.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: context.heightPct(1.8)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: context.heightPct(1)),
              child: Text(
                thread.lastMessageAt != null
                    ? Time_Calculate().getTimeAgo(thread.lastMessageAt!)
                    : "",
                style: TextStyle(fontSize: context.heightPct(1.6)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
