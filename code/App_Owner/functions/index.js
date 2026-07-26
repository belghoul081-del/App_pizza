// ============================================================================
// Cloud Function - الجزء الناقص الوحيد لإتمام الإشعارات والتطبيق مغلق تمامًا
// ============================================================================
// ⚠️ يتطلب هذا خطة Blaze (Pay-as-you-go) - نفس القيد المتكرر مع Storage سابقًا.
// التكلفة هنا زهيدة جدًا عمليًا (دالتان تُستدعيان بضع مرات يوميًا فقط).
//
// خطوات التثبيت:
// 1. من Terminal داخل مجلد المشروع (وليس مجلد lib):
//    npm install -g firebase-tools
//    firebase login
//    firebase init functions   (اختر لغة JavaScript، Node 20)
// 2. انسخ هذا الملف فوق functions/index.js الناتج
// 3. daftar:
//    firebase deploy --only functions
// ============================================================================

const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");

initializeApp();
const db = getFirestore();

/// يُشغَّل تلقائيًا عند إنشاء أي طلب جديد في مجموعة "orders"
exports.onNewOrder = onDocumentCreated("orders/{orderId}", async (event) => {
  const order = event.data.data();

  // جلب توكن المالك (المستند الوحيد في مجموعة "owners")
  const ownersSnap = await db.collection("owners").limit(1).get();
  if (ownersSnap.empty) return;

  const token = ownersSnap.docs[0].data().fcmToken;
  if (!token) return;

  await getMessaging().send({
    token,
    notification: {
      title: "طلب جديد",
      body: `طلب من ${order.client?.name ?? "زبون"} بقيمة ${order.totalOrderPrice ?? 0} Da`,
    },
    android: { priority: "high" },
  });
});

/// يُشغَّل تلقائيًا عند إضافة رسالة جديدة في أي محادثة
exports.onNewChatMessage = onDocumentCreated(
  "chats/{chatId}/messages/{messageId}",
  async (event) => {
    const message = event.data.data();

    // لا نرسل إشعارًا للمالك عن رسائله هو نفسه
    if (message.senderId === "owner") return;

    const ownersSnap = await db.collection("owners").limit(1).get();
    if (ownersSnap.empty) return;

    const token = ownersSnap.docs[0].data().fcmToken;
    if (!token) return;

    const chatDoc = await db
      .collection("chats")
      .doc(event.params.chatId)
      .get();
    const clientName = chatDoc.data()?.clientName ?? "زبون";

    await getMessaging().send({
      token,
      notification: {
        title: `رسالة من ${clientName}`,
        body: message.text || "📷 صورة",
      },
      android: { priority: "high" },
    });
  }
);
