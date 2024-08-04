import 'package:flutter/material.dart';
import 'package:medina_stores/config/resources/color_palettes/color_palette.dart';
import 'package:medina_stores/config/text_styles/app_font_weights.dart';

abstract class AppTextStyle {
  /// App bar title style
  TextStyle get appBarTitleStyle;

  /// TextFormField styles for label, hint and field at [InputDecorationTheme]
  TextStyle get labelTextStyle;
  TextStyle get hintTextStyle;
  TextStyle get fieldStyle;
  TextStyle get mandatoryStyle;
  TextStyle get optionalStyle;
  TextStyle get errorStyle;
}

class LightAppTextStyles implements AppTextStyle {
  final ColorPalette colorPalette;

  const LightAppTextStyles(this.colorPalette);

  @override
  TextStyle get appBarTitleStyle => const TextStyle(fontSize: 20, color: ColorPalette.blackColor);
  @override
  TextStyle get labelTextStyle => const TextStyle(fontSize: 14, color: ColorPalette.blackColor);
  @override
  TextStyle get hintTextStyle => const TextStyle(fontSize: 14, color: ColorPalette.blackColor);
  @override
  TextStyle get fieldStyle => const TextStyle(fontSize: 14, color: ColorPalette.blackColor);
  @override
  TextStyle get mandatoryStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold, color: Colors.red);
  @override
  TextStyle get errorStyle => TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: colorPalette.error);
  @override
  TextStyle get optionalStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: ColorPalette.blackColor);
}

class DarkAppTextStyles implements AppTextStyle {
  final ColorPalette colorPalette;

  const DarkAppTextStyles(this.colorPalette);

  @override
  TextStyle get appBarTitleStyle => const TextStyle(fontSize: 20, color: ColorPalette.whiteColor);
  @override
  TextStyle get labelTextStyle => const TextStyle(fontSize: 14, color: ColorPalette.whiteColor);
  @override
  TextStyle get hintTextStyle => const TextStyle(fontSize: 14, color: ColorPalette.whiteColor);
  @override
  TextStyle get fieldStyle => const TextStyle(fontSize: 14, color: ColorPalette.whiteColor);
  @override
  TextStyle get mandatoryStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold, color: Colors.red);
  @override
  TextStyle get errorStyle => TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: colorPalette.error);
  @override
  TextStyle get optionalStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: ColorPalette.blackColor);
}
