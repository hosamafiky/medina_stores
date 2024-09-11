import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

import '../navigation/navigator.dart';

extension FormatString on String {
  String get capitalize {
    if (isEmpty) return this;

    final words = split(' ');
    final capitalizedWords = words.map((word) {
      final firstLetter = word[0].toUpperCase();
      final rest = word.substring(1);
      return '$firstLetter$rest';
    });
    return capitalizedWords.join(' ');
  }

  String asCurrency() {
    final formatter = NumberFormat("#,###");
    return formatter.format(double.parse(this));
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this));
  }

  String get localize => this.tr();

  bool isNumeric() => double.tryParse(this) != null;

  String toCamelCase() =>
      this[0].toUpperCase() +
      substring(1).replaceAllMapped(
        RegExp('[_-](.)'),
        (Match match) => match.group(1)!.toLowerCase(),
      );

  String get localized {
    final locale = AppNavigator.rootContext!.locale;
    final arabicNumbers = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String translatedString = '';
    for (int i = 0; i < length; i++) {
      final char = this[i];
      final translatedChar = arabicNumbers[char] ?? char;
      translatedString += translatedChar;
    }

    return locale.languageCode == 'ar' ? translatedString : this;
  }
}

extension FormatDouble on double {
  String asCurrency() {
    final formatter = NumberFormat("#,###");
    return formatter.format(this);
  }
}
