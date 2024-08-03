import 'package:flutter/material.dart';

import '../../config/text_styles/app_text_styles.dart';

extension FormFieldExtension on Widget {
  FormField<T> asFormField<T>({
    required FormFieldValidator<T>? validator,
    T? initialValue,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    FormFieldBuilder<T>? builder,
  }) {
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: AppTextStyle.errorStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}
