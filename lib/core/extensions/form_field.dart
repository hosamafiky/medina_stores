import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/resources/color_palettes/color_palette.dart';
import '../../config/text_styles/app_text_styles.dart';
import 'context.dart';

extension FormFieldExtension on Widget {
  FormField<T> asFormField<T>({
    required FormFieldValidator<T>? validator,
    T? initialValue,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    EdgeInsetsGeometry? errorTextPadding,
    FormFieldBuilder<T>? builder,
  }) {
    TextStyle getErrorStyle(BuildContext context) {
      if (context.isDark()) {
        return const DarkAppTextStyles(DarkModeColorPalette()).errorStyle;
      } else {
        return const LightAppTextStyles(LightModeColorPalette()).errorStyle;
      }
    }

    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      onSaved: onSaved,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            this,
            if (state.errorText != null)
              Padding(
                padding: errorTextPadding ?? EdgeInsetsDirectional.only(start: 25.w),
                child: Text(
                  state.errorText!,
                  style: getErrorStyle(state.context),
                ),
              ),
          ],
        );
      },
    );
  }
}
