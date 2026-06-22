import 'package:flutter/material.dart';

// ignore: camel_case_types
class AppImage_background extends StatelessWidget {
  const AppImage_background({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.25,
      child: Image.asset("assets/images/background.png", fit: BoxFit.fill),
    );
  }
}

// ignore: camel_case_types
class AppImage_Logo extends StatelessWidget {
  final double size;
  final String image;
  const AppImage_Logo({super.key, required this.size, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Image.asset(image, fit: BoxFit.fill),
    );
  }
}
