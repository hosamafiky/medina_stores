import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/standards/app_constants.dart';
import '../resources/color_palettes/color_palette.dart';
import '../text_styles/app_text_styles.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

class AppTheme {
  static ThemeData light(ColorPalette palette, AppTextStyle styles) => lightTheme(palette, styles);
  static ThemeData dark(ColorPalette palette, AppTextStyle styles) => darkTheme(palette, styles);
}
