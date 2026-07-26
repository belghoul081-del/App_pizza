import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget image_rchma(BuildContext context) {
  return Align(
    alignment:
        Alignment.centerRight,
    child: Opacity(
      opacity: 0.3,
      child: Padding(
        padding: EdgeInsets.only(right: context.heightPct(2)),
        child: Image.asset(
          "assets/images/login_images/rchma.png",
          height: context.heightPct(60),
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
