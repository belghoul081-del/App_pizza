import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

class DashedLineDivider extends StatelessWidget {
  final double height; // ارتفاع المنطقة الحاضنة للخط
  final double dashWidth; // طول الشرطة الواحدة (-)
  final double dashSpace; // المسافة الفارغة بين الشرطات
  final Color color; // لون الخط

  const DashedLineDivider({
    super.key,
    required this.height,
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.heightPct(2),
        // vertical: context.heightPct(1),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // معرفة العرض الكامل المتاح على الشاشة
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            // توليد الشرطات بناءً على المساحة المتاحة ديناميكياً
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}
