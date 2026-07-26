import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/firebase/firestore/service/chats_service.dart';
import 'package:app_pizza_client/firebase/storage/storage_service.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/models/model_chat/chat_Model.dart';
import 'package:app_pizza_client/provider/admin/admin_provider.dart';
import 'package:app_pizza_client/provider/client/client_Provider.dart';
import 'package:app_pizza_client/provider/event/time.dart';
import 'package:app_pizza_client/service/service_PhotoProduct.dart';
import 'package:app_pizza_client/view/chat/widget/bottom_chat.dart';
import 'package:app_pizza_client/view/chat/widget/fullimage.dart';
import 'package:app_pizza_client/view/chat/widget/widget_AppBar_chat.dart';
import 'package:app_pizza_client/widget/custom/costum_image_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Chat_page extends StatefulWidget {
  const Chat_page({super.key});

  @override
  State<Chat_page> createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {
  final ChatsFirestoreService _service = ChatsFirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePickerService_Chat _imagePickerService = ImagePickerService_Chat();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  bool _isSendingImage = false;

  void initState() {
    super.initState();
    // عند فتح الزبون لهذه الصفحة، نعتبر أنه قرأ آخر رد من المالك
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _service.markChatAsRead(user.uid);
    }
  }

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

  Future<void> _send(String text) async {
    if (text.trim().isEmpty) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    await _service.sendMessage(
      chatId: user.uid,
      clientID: clientProvider.client.uID,
      clientName: clientProvider.client.name,
      clientImage: clientProvider.client.image,
      clientNumber: clientProvider.client.number,
      text: text.trim(),
    );
    _scrollToBottom();
  }

  Future<void> _sendImage(ImageSource source) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final imageFile = await _imagePickerService.pickImage(source);
    if (imageFile == null) return;

    setState(() => _isSendingImage = true);
    try {
      final clientProvider = Provider.of<ClientProvider>(
        context,
        listen: false,
      );
      final imageUrl = await _storageService.uploadChatImage(
        chatId: user.uid,
        imageFile: imageFile,
      );

      await _service.sendMessage(
        chatId: user.uid,
        clientID: clientProvider.client.uID,
        clientName: clientProvider.client.name,
        clientImage: clientProvider.client.image,
        clientNumber: clientProvider.client.number,
        imageUrl: imageUrl,
      );
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image failed to send: $e')));
    } finally {
      if (mounted) setState(() => _isSendingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final adminProvider = Provider.of<AdminProvider>(context);
    final timeCalc = Provider.of<Time_Calculate>(context, listen: false);
    final chatId = clientProvider.uid;
    final bool isNetwork =
        clientProvider.client.image.startsWith('http://') ||
        clientProvider.client.image.startsWith('https://');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: Widget_appBar_chat(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: chatId == null
                  ? const Center(child: Text("You must log in first"))
                  : StreamBuilder<List<ChatMessage_Model>>(
                      stream: _service.streamChats(chatId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final messages = snapshot.data!;
                        if (messages.isEmpty) {
                          return const Center(
                            child: Text("Start the conversation now"),
                          );
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
                            final bool isMine = message.senderId == chatId;
                            final String clientImageToSend = isNetwork
                                ? clientProvider.client.image
                                : Client_Model().image;
                            final String senderImage = isMine
                                ? clientImageToSend
                                : (message.senderimage.isNotEmpty
                                      ? message.senderimage
                                      : adminProvider.admin.image);

                            final dynamic rawTime = message.createdAt;
                            final DateTime? messageDateTime = rawTime == null
                                ? null
                                : (rawTime is DateTime
                                      ? rawTime
                                      : rawTime.toDate());

                            return Align(
                              alignment: isMine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ✅ رسالة واردة (من المالك): صورته يسارًا
                                  if (isMine) ...[
                                    SizedBox(width: context.widthPct(2)),
                                    Text(
                                      messageDateTime != null
                                          ? timeCalc.getChatMessageTime(
                                              messageDateTime,
                                            )
                                          : "now",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
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
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    padding: message.isImageMessage
                                        ? const EdgeInsets.all(4)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMine
                                          ? const Color.fromARGB(
                                              255,
                                              255,
                                              186,
                                              90,
                                            )
                                          : const Color.fromARGB(
                                              255,
                                              253,
                                              194,
                                              112,
                                            ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    // ✅ جديد: عرض صورة الرسالة إن وُجدت
                                    child: message.isImageMessage
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      FullScreenImageView(
                                                        imageUrl:
                                                            message.imageUrl,
                                                      ),
                                                ),
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                  // ✅ رسالة صادرة (من الزبون): صورته يمينًا
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
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
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
            Bottom_chat(
              context,
              onSend: _send,
              onSendImage: _sendImage,
              isSendingImage: _isSendingImage,
              controller: _textController,
            ),
          ],
        ),
      ),
    );
  }
}
