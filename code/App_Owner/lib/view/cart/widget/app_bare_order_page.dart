import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';
import 'package:app_owner/view/cart/pages/general_cart_card.dart';
import 'package:flutter/material.dart';

///هذه عنوان للبار
String getCharRange(String text, int maxLength, {bool withDots = true}) {

  // حماية الكود: إذا كان النص أصلاً أقصر من الحد المطلوب، نرجعه كما هو
  if (text.length <= maxLength) {
    return text;
  }

  // قص النص من الحرف الأول (المؤشر 0) حتى الحد الأقصى المطلوب (5 أو 9 مثلاً)
  String truncated = text.substring(0, maxLength);

  // إرجاع النص المقصوص؛ مع نقاط في نهايته إذا كان withDots مفصلاً، أو بدونه
  return withDots ? '$truncated...' : truncated;
}

AppBar AppBar_Order_Page(
  BuildContext context, {
  required String order_ID,
  required String image,
}) {
  return AppBar(
    backgroundColor: ColorApp_Background.backgroundcolor,

    /// icon
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: ColorApp_Icon_border.bottonbrown,
      ),
      iconSize: context.heightPct(6),

      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ),
    toolbarHeight: context.heightPct(10),
    title: Center(
      child: Row(
        children: [
          Text(
            "order :  ${getCharRange(order_ID, 6)}",
            style: TextStyle(
              fontSize: context.heightPct(2.9),
              fontFamily: "InriaSerif",
              color: ColorApp_Icon_border.bottonbrown,
            ),
          ),
          SizedBox(width: context.heightPct(1)),
          Expanded(child: buildOrderIconButton(context, image, () {})),
        ],
      ),
    ),

    /// line
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: ColorApp_Icon_border.bottonbrown,
        height: context.heightPct(0.3),
      ),
    ),
  );
}
