import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/widget/costum_login.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Loading_Page extends StatefulWidget {
  const Loading_Page({super.key});

  @override
  State<Loading_Page> createState() => _Loading_PageState();
}

// ignore: camel_case_types
class _Loading_PageState extends State<Loading_Page> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed("Home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.fill,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Column(
              children: [
                Image.asset("assets/images/logo_first.png"),
                SizedBox(height: 150),
                Center(
                  child: widget_CustomLoading(
                    size: 70.0,
                    color: ColorApp_Icon_border.bottonbrown,
                    bold: 10.0, // التحكم في حجم الدائرة
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
