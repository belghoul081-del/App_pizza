import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

class Logo_Studio extends StatelessWidget {
  const Logo_Studio({super.key});

  @override
  Widget build(BuildContext context) {
    Text funte(String nn) {
      return Text(
        "$nn",
        style: TextStyle(
          fontFamily: "Italiana",
          color: ColorApp_Text.textblack,
          fontSize: context.heightPct(context.heightPct(0.3)),
          letterSpacing: context.heightPct(0.2),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: context.heightPct(1)),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            funte("v:1.0.0"),
            SizedBox(width: context.widthPct(3)),
            funte("noveno studio"),
            SizedBox(width: context.widthPct(3)),
            funte("@2026"),
          ],
        ),
      ),
    );
  }
}
