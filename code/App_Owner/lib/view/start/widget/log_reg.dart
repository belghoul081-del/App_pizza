import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

class Widget_chose_l_or_r extends StatelessWidget {
  final String l_or_r;
  final String text_o;
  final String text_b;
  final VoidCallback onPressed;

  const Widget_chose_l_or_r({
    super.key,
    required this.l_or_r,
    required this.text_o,
    required this.text_b,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Row Row_botton() {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.all(context.heightPct(0.2)),
            child: Image.asset("assets/images/login_images/logo_pizza.png"),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: context.heightPct(4)),
              child: Center(
                child: Text(
                  "$l_or_r",
                  maxLines: 1,
                  style: TextStyle(
                    color: ColorApp_Background.backgroundcolor,
                    fontFamily: "Inter",
                    fontSize: context.heightPct(3),
                    fontWeight: FontWeight.w900,
                    letterSpacing: context.heightPct(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    MaterialButton MaterialButton_costum() {
      return MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: context.heightPct(6),
          width: context.widthPct(55),
          decoration: BoxDecoration(
            color: ColorApp_Botton.bottonOrange,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Row_botton(),
        ),
      );
    }

    RichText RicheText_costum() {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: context.heightPct(3.1),
            wordSpacing: context.heightPct(0.2),
          ),
          children: <TextSpan>[
            TextSpan(
              text: """$text_b""",
              style: TextStyle(color: ColorApp_Text.textblack),
            ),
            TextSpan(
              text: "$text_o",
              style: TextStyle(color: ColorApp_Botton.bottonOrange),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [RicheText_costum(), MaterialButton_costum()],
    );
  }
}
