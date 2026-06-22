import 'package:app_pizza_owner/constant/text/text_logo_studio.dart';
import 'package:app_pizza_owner/view/auth/login_view.dart';
import 'package:app_pizza_owner/view/start/widget/image_text.dart';
import 'package:app_pizza_owner/view/start/widget/log_reg.dart';
import 'package:flutter/material.dart';
import 'package:app_pizza_owner/constant/app_image.dart';
import 'package:app_pizza_owner/constant/app_size.dart';

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
                  SizedBox(height: context.heightPct(7)),
                  Align(
                    alignment: Alignment.center,
                    child: Widget_chose_l_or_r(
                      l_or_r: 'Login',
                      text_o: 'account',
                      text_b: 'b9b9 ',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.heightPct(25.2)),

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
