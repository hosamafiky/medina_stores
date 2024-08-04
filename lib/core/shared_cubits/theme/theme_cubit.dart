import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/config/themes/app_themes.dart';
import 'package:medina_stores/core/helpers/cache_helper.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../../config/text_styles/app_text_styles.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(InitialThemeState());

  void checkForCachedThemeMode() async {
    final String? themeMode = CacheHelper.read(CacheKeys.themeMode) as String?;
    if (themeMode == ThemeMode.dark.name) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }

  void setLightTheme() async {
    const ThemeMode themeMode = ThemeMode.light;
    const ColorPalette colorPalette = LightModeColorPalette();
    const AppTextStyle appTextStyle = LightAppTextStyles(colorPalette);
    final ThemeData themeData = AppTheme.light(colorPalette, appTextStyle);

    emit(UpdateThemeState(
      themeMode: themeMode,
      colorPalette: colorPalette,
      appTextStyle: appTextStyle,
      themeData: themeData,
    ));
  }

  void setDarkTheme() async {
    const ThemeMode themeMode = ThemeMode.dark;
    const ColorPalette colorPalette = DarkModeColorPalette();
    const AppTextStyle appTextStyle = DarkAppTextStyles(colorPalette);
    final ThemeData themeData = AppTheme.dark(colorPalette, appTextStyle);

    emit(UpdateThemeState(
      themeMode: themeMode,
      colorPalette: colorPalette,
      appTextStyle: appTextStyle,
      themeData: themeData,
    ));
  }
}
