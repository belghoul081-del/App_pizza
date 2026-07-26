import 'package:app_owner/firebase/firestore/service/chats_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String kOwnerGeneralChannelId = 'app_owner_channel';
const String kOwnerChatChannelId = 'chat_messages_channel';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final Map<String, DateTime?> _lastNotifiedChats = {};
  bool _isFirstLoad = true;
  final Map<String, List<Message>> _chatHistoryMessages = {};

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings: settings);

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        kOwnerGeneralChannelId,
        'App notifications',
        description: 'Order and Chat Notifications',
        importance: Importance.max,
        playSound: true,
      ),
    );
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        kOwnerChatChannelId,
        'note messages',
        description: 'organizing customer chat messages',
        importance: Importance.max,
        playSound: true,
      ),
    );

    await _setupFirebaseMessaging();
    listenToIncomingChats();
  }

  Future<void> show({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      kOwnerGeneralChannelId,
      'App notifications',
      channelDescription: 'Order and Chat Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );
    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  void listenToIncomingChats() {
    ChatsFirestoreService().streamChats().listen((chatThreads) {
      if (_isFirstLoad) {
        for (var chat in chatThreads) {
          _lastNotifiedChats[chat.chatId] = chat.lastMessageAt;
        }
        _isFirstLoad = false;
        return;
      }

      for (var chat in chatThreads) {
        if (chat.unreadByOwner && chat.lastMessageAt != null) {
          final lastNotifiedTime = _lastNotifiedChats[chat.chatId];

          if (lastNotifiedTime == null ||
              chat.lastMessageAt!.isAfter(lastNotifiedTime)) {
            _lastNotifiedChats[chat.chatId] = chat.lastMessageAt;
            final Person client = Person(
              name: chat.clientName,
              key: chat.chatId,
            );

            _chatHistoryMessages.putIfAbsent(chat.chatId, () => []);
            _chatHistoryMessages[chat.chatId]!.add(
              Message(
                chat.lastMessage ,
                DateTime.now(),
                client,
              ),
            );

            showChatNotification(
              chatId: chat.chatId,
              clientName: chat.clientName,
              messages: _chatHistoryMessages[chat.chatId]!,
            );
          }
        } else {
          _lastNotifiedChats[chat.chatId] = chat.lastMessageAt;
          _chatHistoryMessages[chat.chatId]?.clear();
        }
      }
    });
  }

  Future<void> showChatNotification({
    required String chatId,
    required String clientName,
    required List<Message> messages,
  }) async {
    final Person me = Person(name: 'adminInf', key: 'adminInf');

    final messagingStyle = MessagingStyleInformation(
      me,
      conversationTitle: clientName,
      groupConversation: false,
      messages: messages,
    );

    final androidDetails = AndroidNotificationDetails(
      kOwnerChatChannelId,
      'note messages',
      channelDescription: 'organizing customer chat messages',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: messagingStyle,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: chatId.hashCode,
      title: clientName,
      body: null,
      notificationDetails: details,
    );
  }

  Future<void> _setupFirebaseMessaging() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      show(
        title: message.notification?.title ?? "A new message",
        body: message.notification?.body ?? "",
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    String? token = await _fcm.getToken();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (token != null && currentUser != null) {
      try {
        await ChatsFirestoreService().updateOwnerToken(token);
      } catch (e) {
        print("Error while updating token: $e");
      }
    }

    // ✅ إصلاح: الاستماع لتحديث التوكن حتى لا تتوقف الإشعارات فجأة.
    _fcm.onTokenRefresh.listen((newToken) async {
      if (FirebaseAuth.instance.currentUser != null) {
        await ChatsFirestoreService().updateOwnerToken(newToken);
      }
    });
  }
}
