import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/widget/custom/costum_loading.dart';
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
      Navigator.of(context).pushReplacementNamed("Welcome");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: AppImage_background()),

            Padding(
              padding: EdgeInsets.only(top: context.heightPct(10)),
              child: Column(
                children: [
                  Container(
                    height: context.heightPct(40),
                    width: context.heightPct(40),
                    child: Image.asset(
                      "assets/images/login_images/logo_first.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: context.heightPct(20)),
                  Center(
                    child: widget_CustomLoading(
                      size: context.heightPct(10),
                      bold: context.heightPct(1.35), // التحكم في حجم الدائرة
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
