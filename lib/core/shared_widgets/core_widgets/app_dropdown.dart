import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../extensions/context.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    this.suffixIconColor,
    this.validator,
    required this.onChanged,
    required List<T> items,
    required this.itemMapper,
    this.isOptional = false,
    this.isBordered = true,
    required this.label,
    this.labelTextStyle,
    this.hintTextStyle,
    this.style,
    this.value,
    this.fillColor,
    this.itemAsString,
    this.hint,
    this.maxHeight,
    this.showSearchBox = true,
  })  : _items = items,
        onTap = null;

  /// Built-in dropdown
  final List<T> _items;
  final DropdownMenuItem<T> Function(T)? itemMapper;

  final bool isOptional, showSearchBox, isBordered;
  final Color? fillColor;
  final T? value;
  final String? label;
  final TextStyle? labelTextStyle, hintTextStyle, style;
  final String? hint;
  final Color? suffixIconColor;
  final double? maxHeight;
  final String? Function(T?)? validator;
  final String Function(T)? itemAsString;
  final Function(T?)? onChanged;
  final Future<List<T>> Function(String text)? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final appTextStyle = context.appTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: labelTextStyle ?? appTextStyle.labelTextStyle,
                ),
                if (isOptional) ...[
                  const TextSpan(text: ' '),
                  TextSpan(text: ' (${LocaleKeys.optional.tr()})', style: appTextStyle.optionalStyle),
                ],
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            validator: validator,
            value: value,
            onChanged: onChanged,
            borderRadius: BorderRadius.circular(10.r),
            iconEnabledColor: palette.secondary,
            items: _items.map(itemMapper!).toList(),
            // icon: SvgManager.arrowdown.svg(color: suffixIconColor ?? colorPalette.secondaryColor),
            style: style ?? appTextStyle.fieldStyle.copyWith(fontSize: 12.sp),
            hint: hint != null
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      hint!,
                      style: hintTextStyle ?? appTextStyle.hintTextStyle,
                    ),
                  )
                : null,
            decoration: InputDecoration(
              hintStyle: hintTextStyle ?? appTextStyle.hintTextStyle.copyWith(fontSize: 12.sp),
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: palette.error, width: 1.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
