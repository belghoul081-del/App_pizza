import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:app_pizza_owner/constant/app_size.dart';
import 'package:flutter/material.dart';


Widget Botton_of_avlide_or_not(
  BuildContext context, {
  required ValueChanged<bool> onChanged,
  required bool isOpened,
}) {
  return Transform.scale(
    scale: context.heightPct(0.2),
    child: Switch(
      value: isOpened,
      onChanged: onChanged,
      trackOutlineColor: WidgetStateProperty.all(
        ColorApp_Icon_border.bottonbrown,
      ),
      trackOutlineWidth: WidgetStateProperty.all(1),
      inactiveTrackColor: ColorApp_Background.chate_massege,
      activeThumbColor: ColorApp_Background.appbarecolor,

      thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.add_shopping_cart_sharp,
            color: ColorApp_Icon_border.bottonbrown,
            size: 20,
          );
        }
        return const Icon(
          Icons.production_quantity_limits,
          color: ColorApp_Icon_border.bottonbrown,
          size: 20,
        );
      }),

      thumbColor: WidgetStateProperty.all(
        isOpened ? ColorApp_Botton.bottonOrange : ColorApp_Text.textred,
      ),
    ),
  );
}
