import 'dart:async';
import 'package:app_owner/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:app_owner/models/model_chat/chat_Model.dart';
import 'package:app_owner/firebase/firestore/service/chats_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatsFirestoreService _service = ChatsFirestoreService();
  StreamSubscription<List<ChatThread_Model>>? _subscription;

  List<ChatThread_Model> _threads = [];
  List<ChatThread_Model> get threads => _threads;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final Map<String, DateTime?> _lastSeenMessageAt = {};

  ChatProvider() {
    _listenToChats();
  }

  void _listenToChats() {
    _subscription = _service.streamChats().listen(
      (threads) {
        final bool isFirstLoad = _lastSeenMessageAt.isEmpty && _isLoading;

        if (!isFirstLoad) {
          for (final thread in threads) {
            final previous = _lastSeenMessageAt[thread.chatId];
            final isNewMessage =
                thread.unreadByOwner &&
                thread.lastMessageAt != null &&
                thread.lastMessageAt != previous;

            if (isNewMessage) {
              NotificationService().show(
                title: "A new message",
                body: "${thread.clientName}: ${thread.lastMessage}",
              );
            }
          }
        }

        for (final thread in threads) {
          _lastSeenMessageAt[thread.chatId] = thread.lastMessageAt;
        }

        _threads = threads;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = "Failed to fetch conversations: $e";
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void refreshNow() {
    _subscription?.cancel();
    _listenToChats();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
