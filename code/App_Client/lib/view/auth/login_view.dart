import 'package:app_pizza_client/firebase/auth/auth_provider.dart';
import 'package:app_pizza_client/view/auth/matterial_log_sig_page.dart';
import 'package:app_pizza_client/view/auth/appbare.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login_Page extends StatefulWidget {
  final int x;
  const Login_Page({super.key, required this.x});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _siginINFromKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _siginUpFromKey = GlobalKey<FormState>();

  /// controllers
  TextEditingController controllerNumber = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSignUpNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.x,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    controllerSignUpNumber.dispose();
    controllerPassword.dispose();
    controllerName.dispose();
    controllerNumber.dispose();
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
                onChanged_Number: (val) => controllerNumber.text = val,
                onChanged_Password: (val) => controllerPassword.text = val,
                siginInFromKey: _siginINFromKey,
                valudate_Number: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter your number";
                  }
                  if (value.trim().length < 10) {
                    return "number must be at least 10 characters";
                  }
                  return null;
                },
                valudate_Password: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter password";
                  }
                  if (value.trim().length < 6) {
                    return "password must be at least 6 characters";
                  }

                  return null;
                },
                onPressed: authProvider.isLoading
                    ? () {}
                    : () async {
                        if (_siginINFromKey.currentState!.validate()) {
                          bool success = await authProvider.signIn(
                            controllerNumber.text.trim(),
                            controllerPassword.text,
                          );

                          if (!mounted) return;

                          if (success) {
                            Navigator.of(context).pushReplacementNamed("Home");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Login failed, please verify your phone number and password",
                                ),
                              ),
                            );
                          }
                        }
                      },
              ),
              buildSignUpForm(
                context,
                onChanged_Name: (val) => controllerName.text = val,
                onChanged_Number: (val) => controllerSignUpNumber.text = val,
                onChanged_Password: (val) => controllerPassword.text = val,
                siginUpFromKey: _siginUpFromKey,

                valudate_Name: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter name";
                  }

                  return null;
                },
                valudate_Number: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter number";
                  }
                  if (value.trim().length < 10) {
                    return "number must be at least 10 characters";
                  }

                  return null;
                },
                valudate_Password: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter password";
                  }
                  if (value.trim().length < 6) {
                    return "password must be at least 6 characters";
                  }
                  return null;
                },
                onPressed: authProvider.isLoading
                    ? () {}
                    : () async {
                        if (_siginUpFromKey.currentState!.validate()) {
                          bool success = await authProvider.newaccount(
                            number: controllerSignUpNumber.text.trim(),
                            password: controllerPassword.text,
                            name: controllerName.text.trim(),
                          );

                          if (!mounted) return;

                          if (success) {
                            Navigator.of(context).pushReplacementNamed("Home");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Account creation failed. Please ensure the number is not already in use",
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
