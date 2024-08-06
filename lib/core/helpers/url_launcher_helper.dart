import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<bool> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<bool> sendMail({
    required List<String> emails,
    String? subject,
    String? body,
  }) async {
    final url = 'mailto:${emails.join(',')}?subject=$subject&body=$body';
    return await _launchURL(url);
  }

  static Future<bool> launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    return await _launchURL(url);
  }

  static Future<bool> launchSms(
    String phoneNumber, {
    String? body,
  }) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(body ?? ''),
      },
    );
    return await _launchURL(smsLaunchUri.toString());
  }

  static Future<bool> openFile(String absolutePath) async {
    final Uri uri = Uri.file(absolutePath);

    if (!File(uri.toFilePath()).existsSync()) {
      throw Exception('$uri does not exist!');
    }
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
    return await _launchURL(uri.toString());
  }
}
