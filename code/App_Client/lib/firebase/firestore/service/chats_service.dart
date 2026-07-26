import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_pizza_client/models/model_chat/chat_Model.dart';

class ChatsFirestoreService {
  final CollectionReference _chatsRef = FirebaseFirestore.instance.collection(
    'chats',
  );

  Stream<List<ChatMessage_Model>> streamChats(String chatId) {
    return _chatsRef
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatMessage_Model.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamMyChatThread(
    String chatId,
  ) {
    return _chatsRef
        .doc(chatId)
        .snapshots()
        .map((doc) => doc as DocumentSnapshot<Map<String, dynamic>>);
  }

  Future<void> createChatThread({
    required String clientId,
    required String clientName,
    required String clientImage,
    required String clientNumber,
  }) async {
    await _chatsRef.doc(clientId).set({
      'clientID': clientId,
      'clientName': clientName,
      'clientImage': clientImage,
      'clientNumber':clientNumber,
      'lastMessage': '',
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadByOwner': false,
    }, SetOptions(merge: true));
  }

  /// يرسل رسالة، وينشئ/يحدّث وثيقة المحادثة (بما فيها اسم/صورة الزبون حتى
  /// تظهر مباشرة عند المالك دون أي خطوة إضافية).
  Future<void> sendMessage({
    required String chatId,
    required String clientID,
    required String clientName,
    required String clientImage,
    required String clientNumber,
    String text = '',
    String imageUrl = '',
  }) async {
    final chatDoc = _chatsRef.doc(chatId);
    final message = ChatMessage_Model(
      senderId: chatId,
      text: text,
      createdAt: null,
      senderimage: clientImage,
      imageUrl: imageUrl,
      number: clientNumber,
    );

    await chatDoc.collection('messages').add(message.toMap());

    await chatDoc.set({
      'clientID': clientID,
      'clientName': clientName,
      'clientImage': clientImage,
      'clientNumber': clientNumber,
      'lastMessage': imageUrl.isNotEmpty ? "📷 image" : text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadByOwner': true,
    }, SetOptions(merge: true));
  }
  Future<void> updateChatClientImage(String chatId, String imageUrl) async {
  await _chatsRef.doc(chatId).set(
    {'clientImage': imageUrl},
    SetOptions(merge: true),
  );
}
  Future<void> markChatAsRead(String chatId) {
    return _chatsRef.doc(chatId).set(
      {'unreadByClient': false},
      SetOptions(merge: true),
    );
  }

  Future<void> updateMyToken(String chatId, String token) async {
    await _chatsRef.doc(chatId).set({
      'fcmToken': token,
      'tokenUpdatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
