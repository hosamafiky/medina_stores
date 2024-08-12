import 'dart:convert';

extension MapString on Map<String, dynamic> {
  String get prettify {
    const jsonEncoder = JsonEncoder.withIndent('  ');
    return jsonEncoder.convert(this);
  }
}
