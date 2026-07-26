import 'package:app_owner/constant/app_image.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/firebase/auth/auth_service.dart';
import 'package:app_owner/view/home/home_view.dart';
import 'package:app_owner/view/start/welcome_view.dart';
import 'package:app_owner/widget/custom/costum_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loading_Page extends StatefulWidget {
  const Loading_Page({super.key});

  @override
  State<Loading_Page> createState() => _Loading_PageState();
}

class _Loading_PageState extends State<Loading_Page> {
 

  @override
  Widget build(BuildContext context) {

    // إذا لم يكن هناك إنترنت، اعرض صفحة انقطاع الإنترنت مباشرة

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                              bold: context.heightPct(1.35),
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
          if (snapshot.hasData) {
            return Home_Page();
          } else {
            return Welcome_Page();
          }
        }),
      ),
    );
  }
}
