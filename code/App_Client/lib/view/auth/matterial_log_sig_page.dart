import 'package:app_pizza_client/constant/app_color.dart';
import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/widget/custom/costum_botton.dart';
import 'package:app_pizza_client/view/auth/widget/body/image_rchma.dart';
import 'package:app_pizza_client/view/auth/widget/body/textArea.dart';
import 'package:flutter/material.dart';

Widget buildSignInForm(
  BuildContext context,
  GlobalKey<FormState> siginInFromKey,
  bool rememberMeValue,
  Client_Data clientDataInstance,
  ValueChanged<bool> onRemeberChanged,
) {
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
                maxLength: 14,
                hintText: "Enter your number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  clientDataInstance.number = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze phone number ";
                  }
                  if (value.length < 14) {
                    return "enter 14 number";
                  }
                  return null;
                },
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                isPassword: true,
                context: context,
                label: "Password",
                maxLength: 15,
                hintText: "Enter your password",
                icon: Icons.vpn_key_rounded,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  clientDataInstance.password = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze cheke your password  ";
                  }
                  if (value.length < 8) {
                    return "enter 8 or more words";
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

Widget buildSignUpForm(
  BuildContext context,
  GlobalKey<FormState> siginUpFromKey,
  bool rememberMeValue,
  Client_Data clientDataInstance,
  ValueChanged<bool> onRemeberChanged,
) {
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
                maxLength: null,
                hintText: "Enter your Name",
                icon: Icons.person_rounded,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  clientDataInstance.name = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze enter your name ";
                  }

                  return null;
                },
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                isPassword: false,
                context: context,
                label: "Number",
                maxLength: 14,
                hintText: "Enter your number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  clientDataInstance.number = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze phone number ";
                  }
                  if (value.length < 14) {
                    return "enter 14 number";
                  }
                  return null;
                },
              ),
              SizedBox(height: context.heightPct(1)),
              text_Area(
                isPassword: true,
                context: context,
                label: "Password",
                maxLength: 10,
                hintText: "Enter your password",
                icon: Icons.vpn_key_rounded,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  clientDataInstance.password = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "pleaze cheke your password  ";
                  }
                  if (value.length < 8) {
                    return "enter 8 or more words";
                  }

                  return null;
                },
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
                text: "Sigin Up",
                onPressed: () {
                  if (siginUpFromKey.currentState!.validate()) {}
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
