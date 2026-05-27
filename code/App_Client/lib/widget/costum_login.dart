import 'package:flutter/material.dart';

// ignore: camel_case_types
class widget_CustomLoading extends StatelessWidget {
  final double size;
  final Color color;
  final double bold;
  const widget_CustomLoading({
    super.key,
    required this.size,
    required this.color,
    required this.bold,
  });

  @override
  Widget build(BuildContext context) {
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
