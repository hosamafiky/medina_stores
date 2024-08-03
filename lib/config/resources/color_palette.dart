import 'package:flutter/material.dart';
import 'package:medina_stores/core/extentions/context.dart';
import 'package:medina_stores/core/navigation/navigator.dart';

class ColorPalette {
  /// Determine if the app is in dark mode
  static final bool _isDarkMode = AppNavigator.rootContext.isDark;

  static Color get primaryColor => _isDarkMode ? _DarkModeColorPalette.primaryColor : _LightModeColorPalette.primaryColor;
  static Color get secondaryColor => _isDarkMode ? _DarkModeColorPalette.secondryColor : _LightModeColorPalette.secondryColor;
  static Color get thirdColor => _isDarkMode ? _DarkModeColorPalette.thirdColor : _LightModeColorPalette.thirdColor;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color errorColor = Colors.redAccent;
}

class _LightModeColorPalette {
  static const Color primaryColor = Color(0xFF7EA259);
  static const Color secondryColor = Color(0xFF7EA259);
  static const Color thirdColor = Color(0xFF7EA259);
}

class _DarkModeColorPalette {
  static const Color primaryColor = Color(0xFF7EA259);
  static const Color secondryColor = Color(0xFFF2F6EE);
  static const Color thirdColor = Color(0xFFF2F6EE);
}
