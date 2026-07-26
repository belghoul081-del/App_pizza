import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/text/text_Logo_Studio.dart';
import 'package:app_pizza_client/view/start/widget/image_text.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';

// ignore: camel_case_types
class Welcome_Page extends StatelessWidget {
  const Welcome_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          // fit: StackFit.expand,
          children: [
            /// background image
            Positioned.fill(child: AppImage_background()),

            /// screen
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.heightPct(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// widget
                  Widget_StarePage(
                    text: 'welcome',
                    image: 'assets/images/login_images/logo_first.png',
                  ),

                  /// text
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: context.heightPct(3.1),
                        wordSpacing: context.heightPct(0.2),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Infinity",
                          style: TextStyle(color: ColorApp_Botton.bottonOrange),
                        ),
                        TextSpan(
                          text: """ , for a hot \n and quick meal""",
                          style: TextStyle(color: ColorApp_Text.textbrown),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(23.4)),

                  /// botton
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed("Welcome_chose");
                    },
                    child: Container(
                      height: context.heightPct(8),
                      width: context.widthPct(75),
                      decoration: BoxDecoration(
                        color: ColorApp_Botton.bottonOrange,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.heightPct(1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Get started",
                              style: TextStyle(
                                color: ColorApp_Background.backgroundcolor,
                                fontFamily: "Inter",
                                fontSize: context.heightPct(4),
                                fontWeight: FontWeight.w900,
                                letterSpacing: context.heightPct(0.5),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorApp_Icon_border.bottonbrown,
                              size: context.heightPct(7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.heightPct(3.05)),

                  /// logo
                  LogoStudio(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
