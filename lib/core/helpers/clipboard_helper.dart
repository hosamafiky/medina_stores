import 'package:clipboard/clipboard.dart';

class ClipboardHelper {
  static Future<void> copyToClipboard(String text) async => await FlutterClipboard.copy(text);

  static Future<String> getFromClipboard() async => await FlutterClipboard.paste();

  static Future<bool> copyToClipboardControl(String text) async => await FlutterClipboard.controlC(text);

  static Future<dynamic> getFromClipboardControl() async => await FlutterClipboard.controlV();
}
