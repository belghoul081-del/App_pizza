import 'package:app_pizza_owner/models/admin/Admin_Model.dart';
import 'package:app_pizza_owner/view/auth/matterial_log_sig_page.dart';
import 'package:app_pizza_owner/view/auth/appbare.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _siginINFromKey = GlobalKey<FormState>();
  final Admin_Model clientDataInstance = Admin_Model();
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: isKeyboardOpen
          ? appbarecostume_II(context, _tabController)
          : appbarecostume_I(context, _tabController),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildSignInForm(
            context,
            _siginINFromKey,
            _rememberMe,
            clientDataInstance,
            (newValue) {
              setState(() {
                _rememberMe = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
