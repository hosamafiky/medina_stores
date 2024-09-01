import 'dart:io';
import 'dart:ui';

import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<ShareResult> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    return await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  static Future<ShareResult> shareFiles(List<File> files, {String? text}) async {
    return await Share.shareXFiles(
      files.map((file) => XFile(file.path)).toList(),
      text: text,
    );
  }

  static Future<ShareResult> shareLink(String url, {Rect? sharePositionOrigin}) async {
    return await Share.shareUri(Uri.parse(url), sharePositionOrigin: sharePositionOrigin);
  }
}
