import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/color_palette.dart';

import '../../../config/text_styles/app_font_weights.dart';

class BaseSubmitButton extends StatelessWidget {
  const BaseSubmitButton({
    super.key,
    this.size,
    this.padding,
    this.foregroundColor,
    this.borderRadius,
    this.backgroundColor,
    required this.onPressed,
    required this.child,
  })  : _borderColor = null,
        _borderWidth = null;

  const BaseSubmitButton.outlined({
    super.key,
    Color? borderColor,
    this.foregroundColor,
    double? borderWidth,
    this.borderRadius,
    this.padding,
    this.size,
    required this.child,
    this.onPressed,
  })  : _borderColor = borderColor,
        backgroundColor = null,
        _borderWidth = borderWidth;

  final Color? _borderColor, backgroundColor, foregroundColor;
  final double? _borderWidth, borderRadius;
  final EdgeInsetsGeometry? padding;
  final Size? size;

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        padding: padding,
        foregroundColor: foregroundColor,
        backgroundColor: _borderColor == null ? backgroundColor : Colors.transparent,
        textStyle: TextStyle(
          color: ColorPalette.whiteColor,
          fontSize: 16.sp,
          fontFamily: 'Kaff',
          fontWeight: AppFontWeight.semiBold,
          // height: 0.14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          side: _borderColor == null ? BorderSide.none : BorderSide(color: _borderColor, width: _borderWidth ?? 1.0),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class BaseButtonWithIcon extends StatelessWidget {
  const BaseButtonWithIcon({
    super.key,
    this.flipDirection = false,
    this.backgroundColor,
    this.textColor,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  /// If you want to keep the current language direction, set it to [null]
  final bool flipDirection;
  final Widget label, icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ((flipDirection ? context.locale.languageCode == 'en' : context.locale.languageCode == 'ar') ? TextDirection.ltr : TextDirection.rtl),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          alignment: Alignment.center,
          textStyle: TextStyle(
            color: ColorPalette.whiteColor,
            fontSize: 16.sp,
            fontFamily: 'Kaff',
            fontWeight: AppFontWeight.semiBold,
            // height: 0.14,
          ),
        ),
        onPressed: onPressed,
        icon: icon,
        label: label,
      ),
    );
  }
}
