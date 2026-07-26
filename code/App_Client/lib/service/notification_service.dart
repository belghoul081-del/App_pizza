import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_pizza_client/firebase/firestore/service/chats_service.dart';

const String kGeneralChannelId = 'app_client_general_channel';
const String kChatChannelId = 'client_chat_messages_channel';

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

  DateTime? _lastNotifiedMessageTime;
  bool _isFirstLoad = true;
  final List<Message> _chatHistoryMessages = [];

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

    // ✅ إنشاء القنوات صراحة بأهمية قصوى حتى تظهر heads-up مع صوت،
    // سواء عرضها كودنا محليًا أو عرضها النظام تلقائيًا من رسالة FCM.
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        kGeneralChannelId,
        'General Notifications',
        description: 'Order status notifications and alerts',
        importance: Importance.max,
        playSound: true,
      ),
    );
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        kChatChannelId,
        'Support and Order Messages',
        description: 'Notifications for incoming messages from app management',
        importance: Importance.max,
        playSound: true,
      ),
    );

    final String? currentUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUid == null) {
      return;
    }

    await _setupFirebaseMessaging(currentUid);
    listenToOwnerMessages(currentUid);
  }

  Future<void> show({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      kGeneralChannelId,
      'General Notifications',
      channelDescription: 'Order status notifications and alerts',
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

  /// الاستماع لمحادثة الزبون الحالي مع المالك عبر Firestore Stream
  void listenToOwnerMessages(String chatId) {
    // ⚠️ استبدل streamMyChat() بالدالة التي تجلب محادثة الزبون الحالي عندك
    ChatsFirestoreService().streamMyChatThread(chatId).listen((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return;

      final data = snapshot.data()!;
      final Timestamp? timestamp = data['lastMessageAt'] as Timestamp?;
      final DateTime? lastMessageAt = timestamp?.toDate();

      // نتحقق مما إذا كانت هناك رسالة غير مقروءة من قبل الزبون
      final bool unreadByClient = data['unreadByClient'] ?? false;
      final String lastMessage = data['lastMessage'] ?? 'New message';

      // 1. عند الفتح لأول مرة، نحفظ وقت آخر رسالة لمنع الإشعارات القديمة
      if (_isFirstLoad) {
        _lastNotifiedMessageTime = lastMessageAt;
        _isFirstLoad = false;
        return;
      }

      // 2. التحقق مما إذا كانت هناك رسالة جديدة ولم يقم الزبون بقراءتها
      if (unreadByClient && lastMessageAt != null) {
        if (_lastNotifiedMessageTime == null ||
            lastMessageAt.isAfter(_lastNotifiedMessageTime!)) {
          _lastNotifiedMessageTime = lastMessageAt;

          final Person owner = Person(
            name: 'Restaurant management',
            key: 'owner',
          );

          _chatHistoryMessages.add(Message(lastMessage, DateTime.now(), owner));

          showChatNotification(
            senderName: 'Restaurant management',
            messages: _chatHistoryMessages,
          );
        }
      } else {
        // إذا قرأ الزبون الرسائل داخل التطبيق، ننظف سجل الهاتف
        _lastNotifiedMessageTime = lastMessageAt;
        _chatHistoryMessages.clear();
      }
    });
  }

  /// إشعار مخصص للرسائل يشبه إشعارات الواتساب والتطبيقات الاحترافية
  Future<void> showChatNotification({
    required String senderName,
    required List<Message> messages,
  }) async {
    // تحديد الزبون (المستخدم الحالي للهاتف)
    final Person me = Person(name: 'me', key: 'me');

    final messagingStyle = MessagingStyleInformation(
      me,
      conversationTitle: senderName,
      groupConversation: false,
      messages: messages,
    );

    final androidDetails = AndroidNotificationDetails(
      'client_chat_messages_channel',
      'Support and request messages',
      channelDescription:
          'Notifications for incoming messages from app management',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: messagingStyle,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: 888,
      title: senderName,
      body: null,
      notificationDetails: details,
    );
  }

  Future<void> _setupFirebaseMessaging(String chatId) async {
    // 1. طلب الأذونات
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    // 2. تسجيل معالج الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. الاستماع لإشعارات FCM المباشرة (في حال استخدمتها مستقبلاً عبر السيرفر)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      show(
        title: message.notification?.title ?? "New alert",
        body: message.notification?.body ?? "",
      );
    });

    // 4. جلب التوكن وحفظه في الفايرستور ليتمكن المالك من إرسال Push Notification مستقبلاً
    String? token = await _fcm.getToken();
    if (token != null) {
      // ⚠️ استدعاء دالة حفظ التوكن في مستند الزبون
      await ChatsFirestoreService().updateMyToken(chatId, token);
    }
  }
}
