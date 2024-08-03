import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isDark => theme.brightness == Brightness.dark;
  bool get isLight => theme.brightness == Brightness.light;
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
