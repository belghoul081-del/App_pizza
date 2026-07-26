import 'package:app_owner/firebase/auth/auth_provider.dart';
import 'package:app_owner/view/auth/matterial_log_sig_page.dart';
import 'package:app_owner/view/auth/appbare.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _siginINFromKey = GlobalKey<FormState>();

  /// controllers
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

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
    controllerEmail.dispose();
    controllerPassword.dispose();
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
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              buildSignInForm(
                context,
                onChanged_ID: (val) => controllerEmail.text = val,
                onChanged_Password: (val) => controllerPassword.text = val,
                siginInFromKey: _siginINFromKey,
                valudate_ID: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter your email";
                  }
                  return null;
                },
                valudate_Password: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter password";
                  }

                  return null;
                },
                onPressed: authProvider.isLoading
                    ? () {}
                    : () async {
                        if (_siginINFromKey.currentState!.validate()) {
                          bool success = await authProvider.signIn(
                            controllerEmail.text.trim(),
                            controllerPassword.text,
                          );

                          if (!mounted) return;

                          if (success) {
                            Navigator.of(context).pushReplacementNamed("Home");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Login failed, check your email and password",
                                ),
                              ),
                            );
                          }
                        }
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
