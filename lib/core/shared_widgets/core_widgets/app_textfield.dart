import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../config/text_styles/app_text_styles.dart';
import '../../extensions/context.dart';
import '../../extensions/spaced_column.dart';
import '../input_formatters/arabic_numbers_formatter.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.hintText,
    this.errorText,
    this.hintStyle,
    this.labelStyle,
    this.style,
    this.isMandatory = true,
    this.isOptional = false,
    this.isBordered = true,
    this.obscureText = false,
    this.showPasswordEye = true,
    this.obscuringCharacter = '•',
    this.controller,
    this.focusNode,
    this.fillColor,
    this.keyboardType,
    this.debounceOnChanged = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.contentPadding,
    this.readOnly = false,
    this.textAlign,
    this.enableinteractiveSelection = true,
    this.hintTextDirection,
    this.textDirection,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
  })  : label = null,
        assert(
          isOptional && !isMandatory || isMandatory && !isOptional,
          'isOptional and isMandatory cannot be true at the same time',
        );

  const AppTextField.withLabel({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.hintText,
    this.errorText,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.isOptional = false,
    this.isMandatory = true,
    this.isBordered = true,
    this.showPasswordEye = true,
    required this.label,
    this.fillColor,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textAlign,
    this.hintTextDirection,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
    this.contentPadding,
    this.textDirection,
    this.validator,
    this.debounceOnChanged = true,
    this.enableinteractiveSelection = true,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
  })  : assert(label != null, 'Label must not be null'),
        assert(
          isOptional && !isMandatory || isMandatory && !isOptional,
          'isOptional and isMandatory cannot be true at the same time',
        );

  final int maxLines, minLines;

  final String? label;
  final String? hintText, errorText;
  final String obscuringCharacter;
  final TextStyle? hintStyle, style, labelStyle;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextDirection? hintTextDirection, textDirection;
  final bool readOnly, isOptional, isMandatory, isBordered, debounceOnChanged, obscureText, showPasswordEye;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixIcon, prefixIcon, suffix, prefix;
  final bool enableinteractiveSelection;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged, onSaved;
  final void Function()? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _debouncer = PublishSubject<String>();
  final InputBorder _noneBorder = OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r));
  @override
  void initState() {
    if (widget.onChanged != null) {
      _debouncer.stream.debounceTime(const Duration(milliseconds: 1000)).listen(widget.onChanged);
    }
    super.initState();
  }

  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  void toggleObscurity() {
    _isObscure.value = !_isObscure.value;
  }

  @override
  void dispose() {
    _debouncer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyle appTextStyle = context.appTextStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: widget.labelStyle ?? appTextStyle.labelTextStyle,
                ),
                if (widget.isMandatory) TextSpan(text: ' *', style: appTextStyle.mandatoryStyle),
                if (widget.isOptional)
                  TextSpan(
                    text: ' (${LocaleKeys.optional.tr()})',
                    style: appTextStyle.optionalStyle,
                  ),
              ],
            ),
          ),
        ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, isObscure, child) {
            return TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              focusNode: widget.readOnly ? AlwaysDisabledFocusNode() : widget.focusNode,
              controller: widget.controller,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              textDirection: widget.textDirection,
              validator: widget.validator,
              onChanged: widget.onChanged != null && widget.debounceOnChanged ? _debouncer.add : widget.onChanged,
              onSaved: widget.onSaved,
              maxLines: widget.maxLines,
              obscureText: isObscure && widget.obscureText,
              obscuringCharacter: widget.obscuringCharacter,
              minLines: widget.minLines,
              enableSuggestions: !widget.enableinteractiveSelection,
              inputFormatters: List<TextInputFormatter>.from(widget.inputFormatters)..add(ArabicNumbersFormatter()),
              autovalidateMode: widget.autovalidateMode,
              keyboardType: widget.keyboardType,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: widget.textInputAction,
              enableInteractiveSelection: widget.enableinteractiveSelection,
              style: widget.style,
              textAlign: widget.textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                hintTextDirection: widget.hintTextDirection,
                hintStyle: widget.hintStyle,
                errorText: widget.errorText,
                fillColor: widget.fillColor,
                border: !widget.isBordered ? _noneBorder : null,
                enabledBorder: !widget.isBordered ? _noneBorder : null,
                focusedBorder: !widget.isBordered ? _noneBorder : null,
                errorBorder: !widget.isBordered ? _noneBorder : null,
                suffixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: (widget.showPasswordEye && widget.obscureText)
                      ? GestureDetector(
                          onTap: toggleObscurity,
                          child: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        )
                      : widget.suffixIcon,
                ),
                suffixIconConstraints: BoxConstraints(minHeight: 20.w, minWidth: 20.w, maxHeight: 20.w),
                prefixIcon: widget.prefixIcon,
                suffix: widget.suffix,
                prefix: widget.prefix,
              ),
            );
          },
        ),
      ],
    ).withSpacing(spacing: 8.h);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
