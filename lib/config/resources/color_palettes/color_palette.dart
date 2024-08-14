import 'package:flutter/material.dart';

part 'dark_color_palette.dart';
part 'light_color_palette.dart';

abstract class ColorPalette {
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  Color get primary;
  Color get primaryVariant;
  Color get secondary;

  Color get background;
  Color get surface;
  Color get error;
  Color get onBackground;
  Color get onSurface;

  Color get primaryText;
  Color get secondaryText;
  Color get disabledText;
  Color get hintText;
  Color get fieldFill;

  Color get accent;
  Color get link;

  Color get divider;
  Color get border;
  Color get shimmerBaseColor;
  Color get shimmerHighlightColor;

  Color get cardBackground;
  Color get cardShadow;

  Color get currentSliderDotColor;
  Color get otherSliderDotColor;

  Color get buttonBackground;
  Color get buttonDisabled;
  Color get buttonText;

  Color get bottomNavigationSelected;
  Color get bottomNavigationUnselected;
  Color get bottomNavigationBackground;

  Color get success;
  Color get warning;
  Color get info;
}
