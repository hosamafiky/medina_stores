import 'package:flutter/material.dart';

import '../resources/color_palettes/color_palette.dart';
import '../text_styles/app_text_styles.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppTheme {
  static ThemeData light(ColorPalette palette, AppTextStyle styles) => lightTheme(palette, styles);
  static ThemeData dark(ColorPalette palette, AppTextStyle styles) => darkTheme(palette, styles);
}
