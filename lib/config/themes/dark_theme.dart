import 'package:flutter/material.dart';

import '../resources/color_palettes/color_palette.dart';
import '../text_styles/app_text_styles.dart';

ThemeData darkTheme(
  ColorPalette palette,
  AppTextStyle appTextStyle,
) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: palette.primary,
    primaryColorDark: palette.primaryVariant,
    secondaryHeaderColor: palette.secondary,
    scaffoldBackgroundColor: palette.background,
    dividerColor: palette.divider,
    cardColor: palette.cardBackground,
    shadowColor: palette.cardShadow,
    appBarTheme: AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: ColorPalette.whiteColor),
      titleTextStyle: appTextStyle.appBarTitleStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: appTextStyle.labelTextStyle,
      hintStyle: appTextStyle.hintTextStyle,
      errorStyle: appTextStyle.errorStyle,
    ),
  );
}
