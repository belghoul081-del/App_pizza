import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:app_pizza_client/view/auth/widget/body/image_rchma.dart';
import 'package:app_pizza_client/view/auth/widget/body/textArea.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildSignInForm(
  BuildContext context, {
  required GlobalKey<FormState> siginInFromKey,
  required Function(String) onChanged_Number,
  required String? Function(String?)? valudate_Number,
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
                isPassword: false,
                context: context,
                label: "Number",
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                hintText: "Enter your number",
                icon: Icons.phone,
                keyboardType: TextInputType.text,
                onChanged: onChanged_Number,
                validator: valudate_Number,
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
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
                child: SizedBox(
                  height: context.heightPct(4),
                  child: Padding(
                    padding: EdgeInsets.only(right: context.heightPct(1)),
                  ),
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

Widget buildSignUpForm(
  BuildContext context, {
  required GlobalKey<FormState> siginUpFromKey,

  required Function(String) onChanged_Name,
  required String? Function(String?)? valudate_Name,

  required Function(String) onChanged_Number,
  required String? Function(String?)? valudate_Number,
  required Function(String) onChanged_Password,
  required String? Function(String?)? valudate_Password,

  required Function() onPressed,
}) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        image_rchma(context),
        Form(
          key: siginUpFromKey,
          child: Column(
            children: [
              SizedBox(height: context.heightPct(10)),
              text_Area(
                isPassword: false,
                context: context,
                label: "Name",
                maxLength: 16,
                hintText: "Enter your name",
                icon: Icons.badge,
                keyboardType: TextInputType.text,
                onChanged: onChanged_Name,
                validator: valudate_Name,
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                isPassword: false,
                context: context,
                label: "Number",
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                maxLength: 10,
                hintText: "Enter your number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: onChanged_Number,
                validator: valudate_Number,
              ),

              SizedBox(height: context.heightPct(1)),
              text_Area(
                isPassword: false,
                context: context,
                label: "Password",
                maxLength: 16,
                hintText: "Enter your password",
                icon: Icons.key,
                keyboardType: TextInputType.text,
                onChanged: onChanged_Password,
                validator: valudate_Password,
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: context.heightPct(4),
                  child: Padding(
                    padding: EdgeInsets.only(right: context.heightPct(1)),
                  ),
                ),
              ),
              Widget_botton(
                context,
                text: "Sigin Up",
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
