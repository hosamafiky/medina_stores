import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extentions/context.dart';
import 'package:pinput/pinput.dart';

import '../../../config/resources/color_palettes/color_palette.dart';

class OtpTextField extends StatelessWidget {
  final ValueChanged<String>? onCompleted;
  final TextEditingController controller;
  final Widget Function(int)? separatorBuilder;
  final int length;

  const OtpTextField({
    super.key,
    required this.controller,
    required this.length,
    this.separatorBuilder,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = context.colorPalette;

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey[400]!),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: palette.primary),
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: palette.error),
    );
    return Pinput(
      length: length,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      autofocus: true,
      separatorBuilder: separatorBuilder,
      focusedPinTheme: focusedPinTheme,
      defaultPinTheme: defaultPinTheme,
      errorPinTheme: errorPinTheme,
      onCompleted: onCompleted,
      controller: controller,
    );
  }
}
