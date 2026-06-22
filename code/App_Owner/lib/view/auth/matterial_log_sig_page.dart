import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:app_pizza_owner/models/admin/Admin_Model.dart';
import 'package:app_pizza_owner/widget/custom/costum_botton.dart';
import 'package:app_pizza_owner/view/auth/widget/body/image_rchma.dart';
import 'package:app_pizza_owner/view/auth/widget/body/textArea.dart';
import 'package:flutter/material.dart';

Widget buildSignInForm(
  BuildContext context,
  GlobalKey<FormState> siginInFromKey,
  bool rememberMeValue,
  Admin_Model Admin_Model,
  ValueChanged<bool> onRemeberChanged,
) {
  final chekInf = Admin_Model;
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
                maxLength: 10,
                hintText: "Enter your ID",
                icon: Icons.badge,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  Admin_Model.number = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze phone number ";
                  }
                  if (value.length < 10) {
                    return "enter 10 number";
                  }
                  if (value != chekInf.number) {
                    return "you are enter wrong password";
                  }

                  return null;
                },
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                chose: 0,
                isPassword: true,
                context: context,
                label: "Password",
                maxLength: 15,
                hintText: "Enter your password",
                icon: Icons.vpn_key_rounded,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  Admin_Model.password = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze cheke your password  ";
                  }
                  if (value.length < 8) {
                    return "enter 8 or more words";
                  }
                  if (value != chekInf.password) {
                    return "you are enter wrong password";
                  }

                  return null;
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: context.heightPct(1)),
                    child: Text(
                      "forget password",
                      style: TextStyle(
                        color: ColorApp_Text.textbrown,
                        fontSize: context.heightPct(2),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: context.heightPct(1)),
                      child: Checkbox(
                        checkColor: ColorApp_Icon_border.bottonbrown,
                        activeColor: const Color.fromARGB(0, 0, 0, 0),
                        side: WidgetStateBorderSide.resolveWith((states) {
                          return BorderSide(
                            color: ColorApp_Icon_border.bottonbrown,
                            width: context.heightPct(0.2),
                          );
                        }),

                        value: rememberMeValue,
                        onChanged: (bool? value) {
                          if (value != null) {
                            onRemeberChanged(value);
                          }
                        },
                      ),
                    ),
                    Text(
                      "remember me",
                      style: TextStyle(
                        color: ColorApp_Text.textblack,
                        fontSize: context.heightPct(2),
                      ),
                    ),
                  ],
                ),
              ),
              Widget_botton(
                context,
                text: "Login",
                onPressed: () {
                  if (siginInFromKey.currentState!.validate()) {
                    Navigator.of(context).pushReplacementNamed("Home");
                  }
                },
                height: 7,
                width: 60,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
