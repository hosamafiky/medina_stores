import 'package:easy_localization/easy_localization.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';

class ValidationHelper {
  // General required field validator used internally
  static String? _validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.empty_validation.tr(namedArgs: {'field': fieldName});
    }
    return null;
  }

  // Validates if the field is not empty
  static String? validateRequiredField(String value, String fieldName) {
    return _validateRequiredField(value, fieldName);
  }

  // Validate if the name is correct format and is required
  static String? validateName(String? value, String fieldName, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, fieldName);
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value != null && value.isNotEmpty) {
      if (value.length < 3) {
        return LocaleKeys.name_validation.tr(
          namedArgs: {'field': fieldName, 'length': '3'},
        );
      }
      const namePattern = r'^[a-zA-Z\s]+$';
      final regex = RegExp(namePattern);
      if (!regex.hasMatch(value)) {
        return LocaleKeys.name_format_validation.tr(namedArgs: {'field': fieldName});
      }
    }
    return null;
  }

  // Validates if the email is in correct format and is required
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, LocaleKeys.email.tr());

      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value != null && value.isNotEmpty) {
      const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
      final regex = RegExp(emailPattern);
      if (!regex.hasMatch(value)) {
        return LocaleKeys.email_validation.tr();
      }
    }
    return null;
  }

  // Validates if the password meets minimum length and is required
  static String? validatePassword(String? value, {int minLength = 8, bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, LocaleKeys.password.tr());

      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value != null && value.isNotEmpty && value.length < minLength) {
      return LocaleKeys.password_validation.tr(namedArgs: {'length': minLength.toString()});
    }
    return null;
  }

  // Validates if the password and confirm password fields match and are required
  static String? validateConfirmPassword(String? password, String confirmPassword, {bool isRequired = true, String? message}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(confirmPassword, LocaleKeys.confirm_password.tr());
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      return message ?? LocaleKeys.confirm_password_validation.tr();
    }
    return null;
  }

  // Validates if the field contains only digits and is required
  static String? validateNumeric(String value, String fieldName, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, fieldName);
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value.isNotEmpty) {
      const numericPattern = r'^\d+$';
      final regex = RegExp(numericPattern);
      if (!regex.hasMatch(value)) {
        return LocaleKeys.name_validation.tr(
          namedArgs: {'field': fieldName, 'length': '3'},
        );
      }
    }
    return null;
  }

  // Validates if the field contains a valid phone number and is required
  static String? validatePhoneNumber(String? value, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, LocaleKeys.phone.tr());
      if (requiredError != null) return requiredError;
    }

    if (value != null && value.isNotEmpty) {
      const phonePattern = r'^[5|0|3|6|4|9|1|8|7]\d{7}$';
      final regex = RegExp(phonePattern);
      if (!regex.hasMatch(value)) {
        return LocaleKeys.phone_validation.tr();
      }
    }
    return null;
  }
}
