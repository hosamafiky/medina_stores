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
        return '$fieldName must be at least 3 characters';
      }
      const namePattern = r'^[a-zA-Z\s]+$';
      final regex = RegExp(namePattern);
      if (!regex.hasMatch(value)) {
        return '$fieldName must contain only alphabets';
      }
    }
    return null;
  }

  // Validates if the email is in correct format and is required
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, 'Email');
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
      final requiredError = _validateRequiredField(value, 'Password');
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value != null && value.isNotEmpty && value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  // Validates if the password and confirm password fields match and are required
  static String? validateConfirmPassword(String? password, String confirmPassword, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(confirmPassword, 'Confirm Password');
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      return LocaleKeys.confirm_password_validation.tr();
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
        return '$fieldName must contain only digits';
      }
    }
    return null;
  }

  // Validates if the field contains a valid phone number and is required
  static String? validatePhoneNumber(String? value, {bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, 'Phone number');
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

  // Validates if the input is a valid date and is required
  static String? validateDate(String value, {String format = 'dd/MM/yyyy', bool isRequired = true}) {
    if (isRequired) {
      final requiredError = _validateRequiredField(value, 'Date');
      if (requiredError != null) {
        return requiredError;
      }
    }

    if (value.isNotEmpty) {
      try {
        final dateFormat = DateFormat(format);
        dateFormat.parseStrict(value);
      } catch (e) {
        return 'Enter a valid date in $format format';
      }
    }
    return null;
  }

  // Example: Add your own custom validation methods as needed, ensuring to include the required check.
}
