import 'package:flutter/material.dart';
import 'package:medina_stores/config/resources/color_palette.dart';
import 'package:medina_stores/config/text_styles/app_font_weights.dart';

import '../../core/extentions/context.dart';
import '../../core/navigation/navigator.dart';

class AppTextStyle {
  /// Determine if the app is in dark mode
  static final bool _isDarkMode = AppNavigator.rootContext.isDark;

  static TextStyle get bodyText1 => _isDarkMode ? _DarkAppTextStyles.bodyText1 : _LightAppTextStyles.bodyText1;

  static TextStyle get appBarTitleStyle => _isDarkMode ? _DarkAppTextStyles.appBarTitleStyle : _LightAppTextStyles.appBarTitleStyle;

  static TextStyle get errorStyle => const TextStyle(fontSize: 12, color: Colors.red);

  /// TEXT FIELD STYLES
  static TextStyle get labelTextStyle => _isDarkMode ? _DarkAppTextStyles.labelTextStyle : _LightAppTextStyles.labelTextStyle;
  static TextStyle get mandatoryStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold, color: Colors.red);
  static TextStyle get optionalStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: ColorPalette.blackColor);
  static TextStyle get hintTextStyle => const TextStyle(fontSize: 14, color: ColorPalette.blackColor);
  static TextStyle get fieldStyle => const TextStyle(fontSize: 14, color: ColorPalette.blackColor);
}

class _LightAppTextStyles {
  static const TextStyle appBarTitleStyle = TextStyle(fontSize: 20, color: Colors.black);
  static const TextStyle bodyText1 = TextStyle(fontSize: 16, color: Colors.black);
  static const TextStyle labelTextStyle = TextStyle(fontSize: 14, color: Colors.black);
}

class _DarkAppTextStyles {
  static const TextStyle appBarTitleStyle = TextStyle(fontSize: 20, color: Colors.white);
  static const TextStyle bodyText1 = TextStyle(fontSize: 16, color: Colors.white);
  static const TextStyle labelTextStyle = TextStyle(fontSize: 14, color: Colors.white);
}
