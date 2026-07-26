import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage_Model {
  final String senderId;
  final String text;
  final String senderimage;
  final DateTime? createdAt;
  final String imageUrl;
  final String number;

  ChatMessage_Model(
    {
      required this.number, 
    required this.senderId,
    required this.text,
    required this.createdAt,
    required this.senderimage,
    this.imageUrl = '',
  });

  bool get isImageMessage => imageUrl.isNotEmpty;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'senderimage': senderimage,
      'imageUrl': imageUrl,
      'number':number
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
            number: map['number'] ?? '',

    );
  }
}
