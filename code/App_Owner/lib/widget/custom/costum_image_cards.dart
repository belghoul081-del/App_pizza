import 'dart:io';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

/// يعرض صورة المنتج سواء كانت:
/// - asset محلي ("assets/...")
/// - ملف على الجهاز (أثناء المعاينة قبل الرفع)
/// - رابط شبكة قادم من Firebase Storage ("https://...")
Widget Widget_Images_Cards(
  BuildContext context, {
  required String image,
  required double size,
}) {
  final double dimension = context.heightPct(size);

  Widget imageWidget;
  if (image.isEmpty) {
    imageWidget = const Icon(Icons.image_not_supported, color: Colors.white);
  } else if (image.startsWith('http://') || image.startsWith('https://')) {
    imageWidget = Image.network(
      image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, color: Colors.white),
    );
  } else if (image.startsWith('assets/')) {
    imageWidget = Image.asset(image, fit: BoxFit.cover);
  } else {
    imageWidget = Image.file(File(image), fit: BoxFit.cover);
  }

  return Container(
    height: dimension,
    // ⚠️ إصلاح: كانت العرض (width) غير محددة سابقًا، فتُرسم الصورة بيضاويّة
    // (مضغوطة/متمددة) بدل أن تكون دائرة/مربعًا مثاليًا. الآن العرض = الارتفاع دائمًا.
    width: dimension,
    decoration: BoxDecoration(
      color: ColorApp_Icon_border.bottonbrown,
      shape: BoxShape.circle,
      border: Border.all(color: ColorApp_Icon_border.bottonbrown),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: imageWidget,
    ),
  );
}
