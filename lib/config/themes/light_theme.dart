import 'package:flutter/material.dart';

import '../resources/color_palette.dart';
import '../text_styles/app_text_styles.dart';

ThemeData get lightTheme => ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: ColorPalette.whiteColor,
      brightness: Brightness.light,
      dividerColor: ColorPalette.whiteColor.withOpacity(0.5),
      scaffoldBackgroundColor: ColorPalette.whiteColor,
      appBarTheme: AppBarTheme(
        color: ColorPalette.whiteColor,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: AppTextStyle.appBarTitleStyle,
      ),
    );
