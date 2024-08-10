import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/resources/color_palettes/color_palette.dart';
import '../../config/text_styles/app_text_styles.dart';
import '../shared_cubits/theme/theme_cubit.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  //THEME DATA
  ThemeData get currentTheme => read<ThemeCubit>().state.themeData;
  ColorPalette get colorPalette => read<ThemeCubit>().state.colorPalette;
  AppTextStyle get appTextStyle => read<ThemeCubit>().state.appTextStyle;
  bool _watchIsDark() => watch<ThemeCubit>().state.isDarkMode;
  bool _readIsDark() => read<ThemeCubit>().state.isDarkMode;

  bool isDark([bool isWatch = true]) => isWatch ? _watchIsDark() : _readIsDark();

  void toggleTheme(bool isWatch) {
    final cubit = isWatch ? watch<ThemeCubit>() : read<ThemeCubit>();
    final isDark = isWatch ? _watchIsDark() : _readIsDark();
    if (isDark) return cubit.setLightTheme();
    return cubit.setDarkTheme();
  }
}
