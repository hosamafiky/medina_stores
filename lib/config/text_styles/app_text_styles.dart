import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/standards/app_constants.dart';
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

  TextStyle get _baseStyle => const TextStyle(fontFamily: AppConstants.fontFamily);

  @override
  TextStyle get appBarTitleStyle => _baseStyle.copyWith(fontSize: 18.sp, color: ColorPalette.blackColor);
  @override
  TextStyle get labelTextStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.blackColor);
  @override
  TextStyle get hintTextStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.blackColor);
  @override
  TextStyle get fieldStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.blackColor);
  @override
  TextStyle get mandatoryStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold, color: Colors.red);
  @override
  TextStyle get errorStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.regular, color: colorPalette.error);
  @override
  TextStyle get optionalStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.regular, color: ColorPalette.blackColor);

  @override
  TextStyle get elevatedButtonTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get disabledElevatedButtonStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get textButtonTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get textButtonDisabledTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get bottomNavigationSelectedLabelStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get bottomNavigationUnselectedLabelStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold);
}

class DarkAppTextStyles implements AppTextStyle {
  final ColorPalette colorPalette;

  const DarkAppTextStyles(this.colorPalette);

  TextStyle get _baseStyle => const TextStyle(fontFamily: AppConstants.fontFamily);

  @override
  TextStyle get appBarTitleStyle => _baseStyle.copyWith(fontSize: 18.sp, color: ColorPalette.whiteColor);
  @override
  TextStyle get labelTextStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.whiteColor);
  @override
  TextStyle get hintTextStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.whiteColor);
  @override
  TextStyle get fieldStyle => _baseStyle.copyWith(fontSize: 12.sp, color: ColorPalette.whiteColor);
  @override
  TextStyle get mandatoryStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold, color: Colors.red);
  @override
  TextStyle get errorStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.regular, color: colorPalette.error);
  @override
  TextStyle get optionalStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.regular, color: ColorPalette.whiteColor);

  @override
  TextStyle get elevatedButtonTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get disabledElevatedButtonStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get textButtonTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get textButtonDisabledTextStyle => _baseStyle.copyWith(fontSize: 14.sp, fontWeight: AppFontWeight.bold);

  @override
  TextStyle get bottomNavigationSelectedLabelStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold);
  @override
  TextStyle get bottomNavigationUnselectedLabelStyle => _baseStyle.copyWith(fontSize: 10.sp, fontWeight: AppFontWeight.bold);
}
