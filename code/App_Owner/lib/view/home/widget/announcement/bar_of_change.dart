import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';

Widget bar_change_announcement(
  BuildContext context, {
  required int barIndex,
  required int totalBar,
  required PageController controller,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: context.heightPct(0.2)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalBar, (index) {
        return _buildTabDot(context, isActive: index == barIndex);
      }),
    ),
  );
}

Widget _buildTabDot(BuildContext context, {required bool isActive}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: EdgeInsets.symmetric(horizontal: context.heightPct(0.3)),
    width: context.widthPct(15),
    height: context.heightPct(0.5),
    decoration: BoxDecoration(
      color: isActive
          ? ColorApp_Icon_border.bottonbrown
          : ColorApp_Botton.bottonOrange,
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
}
