import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/config/text_styles/app_text_styles.dart';
import 'package:medina_stores/core/shared_cubits/theme/theme_cubit.dart';

import '../../config/resources/color_palettes/color_palette.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isDark => watch<ThemeCubit>().state.isDarkMode;
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  //THEME DATA
  ThemeData get currentTheme => read<ThemeCubit>().state.themeData;
  ColorPalette get colorPalette => read<ThemeCubit>().state.colorPalette;
  AppTextStyle get appTextStyle => read<ThemeCubit>().state.appTextStyle;
}
