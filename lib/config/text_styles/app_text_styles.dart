import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_palettes/color_palette.dart';
import 'app_font_weights.dart';

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

  /// ElevatedButton text style
  TextStyle get elevatedButtonTextStyle;
  TextStyle get disabledElevatedButtonStyle;

  /// TEXT BUTTON STYLE
  TextStyle get textButtonTextStyle;
  TextStyle get textButtonDisabledTextStyle;

  /// BOTTOM NAVIGATION BAR
  TextStyle get bottomNavigationSelectedLabelStyle;
  TextStyle get bottomNavigationUnselectedLabelStyle;
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

  @override
  TextStyle get elevatedButtonTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get disabledElevatedButtonStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get textButtonTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get textButtonDisabledTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get bottomNavigationSelectedLabelStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get bottomNavigationUnselectedLabelStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold);
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
  TextStyle get optionalStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.regular, color: ColorPalette.whiteColor);

  @override
  TextStyle get elevatedButtonTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get disabledElevatedButtonStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get textButtonTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get textButtonDisabledTextStyle => TextStyle(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get bottomNavigationSelectedLabelStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get bottomNavigationUnselectedLabelStyle => const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold);
}
