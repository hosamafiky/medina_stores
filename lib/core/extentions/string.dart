import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

extension FormatString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
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
}

extension FormatDouble on double {
  String asCurrency() {
    final formatter = NumberFormat("#,###");
    return formatter.format(this);
  }
}
