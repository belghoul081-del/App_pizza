import 'package:app_pizza_owner/constant/app_color.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class widget_CustomLoading extends StatelessWidget {
  final double size;
  final double bold;
  const widget_CustomLoading({
    super.key,
    required this.size,
    required this.bold,
  });

  @override
  Widget build(BuildContext context) {
    Color color = ColorApp_Icon_border.bottonbrown;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: bold,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
