import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/widget/custom/costum_Button.dart';
import 'package:app_owner/view/auth/widget/body/image_rchma.dart';
import 'package:app_owner/view/auth/widget/body/textArea.dart';
import 'package:flutter/material.dart';

Widget buildSignInForm(
  BuildContext context, {
  required GlobalKey<FormState> siginInFromKey,
  required Function(String) onChanged_ID,
  required String? Function(String?)? valudate_ID,
  required Function(String) onChanged_Password,
  required String? Function(String?)? valudate_Password,

  required Function() onPressed,
}) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        image_rchma(context),
        Form(
          key: siginInFromKey,
          child: Column(
            children: [
              SizedBox(height: context.heightPct(10)),
              text_Area(
                chose: 1,
                isPassword: false,
                context: context,
                label: "ID",
                maxLength: 30,
                hintText: "Enter your ID",
                icon: Icons.badge,
                keyboardType: TextInputType.text,
                onChanged: onChanged_ID,
                validator: valudate_ID,
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                chose: 0,
                isPassword: true,
                context: context,
                label: "Password",
                maxLength: 16,
                hintText: "Enter your password",
                icon: Icons.vpn_key_rounded,
                keyboardType: TextInputType.text,
                onChanged: onChanged_Password,
                validator: valudate_Password,
              ),
              Align(
                alignment: Alignment.topRight,

                child: Padding(
                  padding: EdgeInsets.only(right: context.heightPct(1)),
                  child: SizedBox(height: context.heightPct(5)),
                ),
              ),
              Widget_botton(
                context,
                text: "Login",
                onPressed: onPressed,
                height: 7,
                width: 60,
                backgroundColor: ColorApp_Botton.bottonOrange,
                textColor: ColorApp_Background.backgroundcolor,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
