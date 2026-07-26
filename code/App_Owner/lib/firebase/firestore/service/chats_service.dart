import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/model_chat/chat_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsFirestoreService {
  final CollectionReference _chatsRef = FirebaseFirestore.instance.collection(
    'chats',
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// أي زبون جديد يرسل أول رسالة له سيظهر هنا تلقائيًا فورًا،
  Stream<List<ChatThread_Model>> streamChats() {
    return _chatsRef
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatThread_Model.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<ChatMessage_Model>> streamMessages(String chatId) {
    return _chatsRef
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatMessage_Model.fromMap(doc.data()))
              .toList(),
        );
  }

  /// يرسل رسالة من المالك ويحدّث ملخص المحادثة (آخر رسالة/وقتها).
  Future<void> sendMessage(
    String chatId,
    String text, {
    required String ownerImage,
    String imageUrl = '',
  }) async {
    final chatDoc = _chatsRef.doc(chatId);
    final message = ChatMessage_Model(
      senderId: 'adminInf',
      text: text,
      createdAt: null,
      senderimage: ownerImage,
      imageUrl: imageUrl,
    );

    await chatDoc.collection('messages').add(message.toMap());

    await chatDoc.set({
      'lastMessage': imageUrl.isNotEmpty ? "📷 image" : text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadByOwner': false,
      'unreadByClient': true,
    }, SetOptions(merge: true));
  }

  Future<void> markChatAsRead(String chatId) {
    return _chatsRef.doc(chatId).update({'unreadByOwner': false});
  }

  Future<void> updateOwnerToken(String token) async {
    try {
      // 1. جلب معرف المالك الحالي المسجل دخوله
      String? uid = _auth.currentUser?.uid;

      if (uid != null) {
        // 2. الوصول للمستند وتحديث التوكن مع الحفاظ على بقية البيانات
        await _firestore.collection('adminInf').doc(uid).set({
          'fcmToken': token,
          'lastTokenUpdate':
              FieldValue.serverTimestamp(), // توثيق وقت التحديث من السيرفر
        }, SetOptions(merge: true));

        print("FCM Token successfully updated in Firestore.");
      } else {
        print("Alert: No currently logged-in owner found to save the token.");
      }
    } catch (e) {
      print("Error updating owner token in Firestore: $e");
    }
  }

  /// ✅ جلب توكن FCM الخاص بالزبون من مجموعة users
  Future<String?> getClientToken(String clientId) async {
    try {
      final doc = await _firestore.collection('users').doc(clientId).get();
      if (doc.exists && doc.data() != null) {
        return doc.data()!['fcmToken'] as String?;
      }
    } catch (e) {
      print("Error while fetching customer token: $e");
    }
    return null;
  }
}
