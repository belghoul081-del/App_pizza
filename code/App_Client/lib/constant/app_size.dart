import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// take haige & width of screen
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// context.widthPct(1),
  double widthPct(double percent) => screenWidth * (percent / 100);

  /// context.heightPct(1),
  double heightPct(double percent) => screenHeight * (percent / 100);

  // 1% => 8px    heightPct
}
