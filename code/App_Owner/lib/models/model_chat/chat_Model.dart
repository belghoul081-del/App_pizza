import 'package:cloud_firestore/cloud_firestore.dart';

/// محادثة واحدة (خيط) بين المالك وزبون معيّن.
class ChatThread_Model {
  final String chatId;
  final String clientName;
  final String clientImage;
  final String lastMessage;
  final String clientNumber;
  final DateTime? lastMessageAt;
  final bool unreadByOwner;

  ChatThread_Model({
    required this.chatId,
    required this.clientName,
    required this.clientImage,
    required this.clientNumber,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadByOwner,
  });

  factory ChatThread_Model.fromMap(String id, Map<String, dynamic> map) {
    return ChatThread_Model(
      chatId: id,
      clientNumber: map['clientNumber'] ?? '',
      clientName: map['clientName'] ?? 'Client',
      clientImage: map['clientImage'] ?? 'assets/images/profila_client.png',
      lastMessage: map['lastMessage'] ?? '',
      unreadByOwner: map['unreadByOwner'] == true,
      lastMessageAt: map['lastMessageAt'] is Timestamp
          ? (map['lastMessageAt'] as Timestamp).toDate()
          : null,
    );
  }
}

/// رسالة واحدة داخل محادثة.
class ChatMessage_Model {
  final String senderId; // 'owner' أو uid الزبون
  final String text;
  final String senderimage;
  final DateTime? createdAt;
  final String imageUrl;

  ChatMessage_Model({
    required this.senderId,
    required this.text,
    required this.createdAt,
    required this.senderimage,
    this.imageUrl = '',
  });

  bool get isFromOwner => senderId == 'adminInf';
  bool get isImageMessage => imageUrl.isNotEmpty;
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'senderimage': senderimage,
      'imageUrl': imageUrl,
    };
  }

  factory ChatMessage_Model.fromMap(Map<String, dynamic> map) {
    return ChatMessage_Model(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      senderimage: map['senderimage'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
