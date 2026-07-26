import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/view/Home_Gate.dart';
import 'package:app_pizza_client/view/start/welcome_view.dart';
import 'package:app_pizza_client/widget/custom/costum_loading.dart';
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
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
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
            return const Home_Gate();
          } else {
            return const Welcome_Page();
          }
        },
      ),
    );
  }
}