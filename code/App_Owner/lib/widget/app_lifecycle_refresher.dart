import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_owner/provider/order/order_Provider.dart';
import 'package:app_owner/provider/chat/chat_Provider.dart';

/// ✅ يلفّ التطبيق بالكامل، ويجبر إعادة الاشتراك بستريمات الطلبات/الدردشة
/// كلما عاد التطبيق من الخلفية (resume). هذا لا يحل مشكلة تحسين البطارية
/// من جذورها (ذلك يحتاج ضبطًا يدويًا من إعدادات الجهاز، موضّح في README)،
/// لكنه يضمن ظهور أي بيانات فائتة فورًا بمجرد أن يفتح المالك التطبيق من
/// جديد، بدل انتظار غير محدد لاستعادة الاتصال القديم تلقائيًا.
class AppLifecycleRefresher extends StatefulWidget {
  final Widget child;
  const AppLifecycleRefresher({super.key, required this.child});

  @override
  State<AppLifecycleRefresher> createState() => _AppLifecycleRefresherState();
}

class _AppLifecycleRefresherState extends State<AppLifecycleRefresher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<OrderProvider>(context, listen: false).refreshNow();
      Provider.of<ChatProvider>(context, listen: false).refreshNow();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
