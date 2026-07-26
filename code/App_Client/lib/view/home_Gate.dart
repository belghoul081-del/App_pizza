import 'package:app_pizza_client/provider/admin/admin_provider.dart';
import 'package:app_pizza_client/provider/blacklist/blacklist_Provider.dart';
import 'package:app_pizza_client/view/blacklist/blacklist_view.dart';
import 'package:app_pizza_client/view/home/home_view.dart';
import 'package:app_pizza_client/view/start/close_open_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_Gate extends StatelessWidget {
  const Home_Gate({super.key});

  @override
  Widget build(BuildContext context) {
    final isBlocked = context.watch<BlacklistProvider>().isBlocked;
    if (isBlocked) return const Blocked_Page();

    final adminProvider = context.watch<AdminProvider>();
    if (!adminProvider.isLoading && !adminProvider.isOpen) {
      return const Store_Closed_Page();
    }

    return const Home_Page();
  }
}
