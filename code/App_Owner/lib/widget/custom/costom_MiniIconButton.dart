import 'package:flutter/material.dart';
import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/constant/app_size.dart';

class CustomMiniIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final double sizePct;

  const CustomMiniIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.sizePct = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.heightPct(sizePct),
      width: context.heightPct(sizePct),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor ?? ColorApp_Background.appbarecolor,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: context.heightPct(sizePct * 0.75),
          color: iconColor ?? ColorApp_Icon_border.bottonbrown,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
