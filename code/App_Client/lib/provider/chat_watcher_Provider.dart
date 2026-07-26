import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/models/model_chat/chat_Model.dart';
import 'package:app_pizza_client/firebase/firestore/service/chats_service.dart';
import 'package:app_pizza_client/service/notification_service.dart';

/// مراقبة خفيفة لمحادثة الزبون الخاصة به فقط، غرضها الوحيد إطلاق إشعار
class ChatWatcherProvider extends ChangeNotifier {
  final ChatsFirestoreService _service = ChatsFirestoreService();
  StreamSubscription<List<ChatMessage_Model>>? _subscription;
  StreamSubscription<User?>? _authSubscription;

  DateTime? _lastSeenMessageAt;
  bool _isFirstLoad = true;

  ChatWatcherProvider() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _subscription?.cancel();
      _lastSeenMessageAt = null;
      _isFirstLoad = true;

      if (user != null) {
        _listen(user.uid);
      }
    });
  }

  void _listen(String uid) {
    _subscription = _service.streamChats(uid).listen((messages) {
      if (messages.isEmpty) return;

      final last = messages.last;
      final isFromOwner = last.senderId == 'owner';
      final isNew =
          last.createdAt != null && last.createdAt != _lastSeenMessageAt;

      if (!_isFirstLoad && isFromOwner && isNew) {
        NotificationService().show(
          title: "A new message from the restaurant",
          body: last.text,
        );
      }

      _lastSeenMessageAt = last.createdAt;
      _isFirstLoad = false;
    });
  }

  void refreshNow() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    _subscription?.cancel();
    _listen(uid);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
