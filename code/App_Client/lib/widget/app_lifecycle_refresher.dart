import 'package:app_pizza_client/provider/chat_watcher_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_pizza_client/provider/order/order_Provider.dart';

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
      Provider.of<ChatWatcherProvider>(context, listen: false).refreshNow();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
