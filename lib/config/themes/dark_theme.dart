import 'package:flutter/material.dart';

import '../resources/color_palette.dart';
import '../text_styles/app_text_styles.dart';

ThemeData get darkTheme => ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      dividerColor: Colors.black12,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: const IconThemeData(color: ColorPalette.whiteColor),
        titleTextStyle: AppTextStyle.appBarTitleStyle,
      ),
    );
