import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/firebase/auth/auth_provider.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blocked_Page extends StatefulWidget {
  const Blocked_Page({super.key});

  @override
  State<Blocked_Page> createState() => _Blocked_PageState();
}

class _Blocked_PageState extends State<Blocked_Page> {
  bool _isProcessing = false;

  Future<void> _signOutAndGoToLogin() async {
    if (_isProcessing || !mounted) return;
    setState(() => _isProcessing = true);
    await Provider.of<AuthProvider>(context, listen: false).logout();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil("Welcome", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp_Background.backgroundcolor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.heightPct(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.block_rounded,
                  color: ColorApp_Text.textred,
                  size: context.heightPct(10),
                ),
                SizedBox(height: context.heightPct(3)),
                Text(
                  "Your current account cannot be accessed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "InterBold",
                    fontSize: context.heightPct(2.6),
                    color: ColorApp_Text.textbrown,
                  ),
                ),
                SizedBox(height: context.heightPct(1.5)),
                Text(
                  "This account has been blocked by the administration, and you will not be able to use the application with this account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.heightPct(1.9),
                    color: ColorApp_Text.textbrown,
                  ),
                ),
                SizedBox(height: context.heightPct(4)),
                _isProcessing
                    ? const CircularProgressIndicator()
                    : Widget_botton(
                        context,
                        text: "Return to login",
                        backgroundColor: ColorApp_Botton.bottonOrange,
                        textColor: ColorApp_Text.textblack,
                        onPressed: _signOutAndGoToLogin,
                        height: 8,
                        width: 90,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
