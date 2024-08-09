import 'dart:io';

import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<ShareResult> shareText(String text) async {
    return await Share.share(text);
  }

  static Future<ShareResult> shareFiles(List<File> files, {String? text}) async {
    return await Share.shareXFiles(files.map((file) => XFile(file.path)).toList(), text: text);
  }

  static Future<ShareResult> shareLink(String url) async {
    return await Share.shareUri(Uri.parse(url));
  }
}
