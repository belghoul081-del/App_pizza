import 'package:app_pizza_client/constant/text/text_logo_studio.dart';
import 'package:app_pizza_client/widget/start_page/image_text.dart';
import 'package:app_pizza_client/widget/start_page/log_reg.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_client/constant/app_image.dart';
import 'package:app_pizza_client/constant/app_size.dart';

class Welcome_chose_L_or_R extends StatelessWidget {
  const Welcome_chose_L_or_R({super.key});

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
                    text: 'login',
                    image: 'assets/images/login_images/logo_seconde.png',
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Widget_chose_l_or_r(
                      l_or_r: 'Login',
                      text_o: 'account',
                      text_b: 'i have ',
                    ),
                  ),
                  SizedBox(height: context.heightPct(5)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Widget_chose_l_or_r(
                      l_or_r: 'register',
                      text_o: 'new',
                      text_b: 'creat ',
                    ),
                  ),
                  SizedBox(height: context.heightPct(17.49)),

                  /// logo
                  Logo_Studio(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
