import 'package:app_pizza_client/constant/app_size.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/view/profile/widget/column_profile.dart';
import 'package:flutter/material.dart';

ClipPath widget_ClipPath(BuildContext context,Client_Model clientInf) {
  return ClipPath(
    clipper: Widget_CustomClipper(context: context),
    child: Container(
      height: context.heightPct(100),
      width: context.widthPct(100),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA11F),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Widget_profile(context,clientInf),
    ),
  );
}

class Widget_CustomClipper extends CustomClipper<Path> {
  final BuildContext context;

  Widget_CustomClipper({required this.context});
  @override
  Path getClip(Size size) {
    // نستخدم نصف عرض الـ Container كمركز حقيقي (سواء كان في المنتصف أو لا)
    double centerX = size.width / 2;
    double holeRadius = context.heightPct(13.5);
    double cornerRadius = 20;

    Path path = Path();

    // نبدأ من الزاوية العلوية اليسرى
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // نتحرك للمركز ناقص نصف قطر الفتحة
    path.lineTo(centerX - holeRadius, 0);

    // القوس: هنا السر، الرسم يجب أن يكون حول المركز centerX
    path.arcToPoint(
      Offset(centerX + holeRadius, 0),
      radius: Radius.circular(holeRadius),
      clockwise: false,
    );

    // إكمال الجزء العلوي الأيمن
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // ... (باقي الرسم للنهاية كما هو)
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
