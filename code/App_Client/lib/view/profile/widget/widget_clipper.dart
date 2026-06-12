import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/view/profile/widget/column_profile.dart';
import 'package:flutter/material.dart';

ClipPath widget_ClipPath(BuildContext context) {
  return ClipPath(
    clipper: Widget_CustomClipper(context: context),
    child: Container(
      height: context.heightPct(100),
      width: context.widthPct(100),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA11F),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Widget_profile(context),
    ),
  );
}

class Widget_CustomClipper extends CustomClipper<Path> {
  final BuildContext context;
  Widget_CustomClipper({required this.context});

  @override
  Path getClip(Size size) {
    // نستخدم الـ context للحصول على قيم متجاوبة
    double holeRadius = context.heightPct(14); // مثال: 10% من ارتفاع الشاشة
    double centerX = size.width / 2;

    Path path = Path();

    // الرسم مع القيم الديناميكية
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    path.lineTo(centerX - holeRadius, 0);

    path.arcToPoint(
      Offset(centerX + holeRadius, 0),
      radius: Radius.circular(holeRadius),
      clockwise: false,
    );

    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
