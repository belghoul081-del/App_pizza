import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/firestore/provider/getData_provider.dart';
import 'package:app_owner/firebase/firestore/service/chats_service.dart';
import 'package:app_owner/models/admin/admin_model.dart';
import 'package:app_owner/models/model_chat/chat_Model.dart';
import 'package:app_owner/provider/event/time.dart';
import 'package:app_owner/view/chat/widget/bottom_chat.dart';
import 'package:app_owner/view/chat/widget/fullimage.dart';
import 'package:app_owner/view/chat/widget/widget_AppBar_chat.dart';
import 'package:app_owner/widget/custom/costum_image_cards.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message_page extends StatefulWidget {
  final String chatId;
  final String clientName;
  final String clientImage;
  final String clientNumber;

  const Message_page({
    super.key,
    required this.chatId,
    required this.clientName,
    required this.clientImage,
    required this.clientNumber,
  });

  @override
  State<Message_page> createState() => _Message_pageState();
}

class _Message_pageState extends State<Message_page> {
  final ChatsFirestoreService _service = ChatsFirestoreService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  String? adminImage;

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch admin image from provider
    final provider = context.read<GetdataProvider>();
    if (provider.admin.isNotEmpty) {
      adminImage = provider.admin[0].image;
    }
  }

  Future<void> _send(String text) async {
    if (text.trim().isEmpty) return;
    await _service.sendMessage(
      widget.chatId,
      text.trim(),
      ownerImage: adminImage ?? '',
    );
    _textController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: Widget_appBar_chat(
        context,
        title: widget.clientName,
        number: widget.clientNumber,
        clientUID: widget.chatId,
        clientImage: widget.clientImage,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessage_Model>>(
                stream: _service.streamMessages(widget.chatId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!;
                  if (messages.isEmpty) {
                    return const Center(child: Text("Start the chat now"));
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    }
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final bool isMine =
                          message.isFromOwner;

                      // تحديد صورة المرسل: إن كانت الرسالة من المالك نستخدم صورة المالك، وإلا نستخدم صورة العميل
                      final String senderImage = isMine
                          ? (message.senderimage.isNotEmpty
                                ? message.senderimage
                                : Admin_Model.defaultImage)
                          : widget.clientImage;

                      final dynamic rawTime = message.createdAt;
                      final DateTime? messageDateTime = rawTime == null
                          ? null
                          : (rawTime is DateTime ? rawTime : rawTime.toDate());

                      final timeCalc = Provider.of<Time_Calculate>(
                        context,
                        listen: false,
                      );

                      return Align(
                        alignment: isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // رسالة واردة (من العميل): صورته يساراً
                            if (isMine) ...[
                              SizedBox(width: context.widthPct(2)),
                              Text(
                                messageDateTime != null
                                    ? timeCalc.getChatMessageTime(
                                        messageDateTime,
                                      )
                                    : "now",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: ColorApp_Text.textbrown,
                                ),
                              ),
                            ],
                            if (!isMine) ...[
                              Widget_Images_Cards(
                                context,
                                image: senderImage,
                                size: 5,
                              ),
                              SizedBox(width: context.widthPct(2)),
                            ],
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: message.isImageMessage
                                  ? const EdgeInsets.all(4)
                                  : const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: isMine
                                    ? const Color.fromARGB(255, 255, 166, 31)
                                    : const Color.fromARGB(255, 255, 196, 107),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: message.isImageMessage
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FullScreenImageView(
                                              imageUrl: message.imageUrl,
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          message.imageUrl,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      message.text,
                                      textAlign: isMine
                                          ? TextAlign.right
                                          : TextAlign.left,
                                    ),
                            ),
                            // رسالة صادرة (من المالك): صورته يميناً
                            if (isMine) ...[
                              SizedBox(width: context.widthPct(2)),
                              Widget_Images_Cards(
                                context,
                                image: senderImage,
                                size: 5,
                              ),
                            ],
                            if (!isMine) ...[
                              Text(
                                messageDateTime != null
                                    ? timeCalc.getChatMessageTime(
                                        messageDateTime,
                                      )
                                    : "now",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: ColorApp_Text.textbrown,
                                ),
                              ),
                              SizedBox(width: context.widthPct(2)),
                            ],
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Bottom_chat(context, onSend: _send),
          ],
        ),
      ),
    );
  }
}
