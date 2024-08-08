import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<bool> launchURL(
    Uri uri, {
    Uri? fallbackUri,
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    BrowserConfiguration browserConfiguration = const BrowserConfiguration(),
  }) async {
    if (await canLaunchUrl(uri)) {
      return await launchUrl(
        uri,
        mode: mode,
        webViewConfiguration: webViewConfiguration,
        browserConfiguration: browserConfiguration,
      );
    } else {
      if (fallbackUri != null) {
        return await launchURL(fallbackUri);
      }
      return false;
    }
  }

  static Future<bool> sendMail({
    required List<String> emails,
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: emails.join(','),
      queryParameters: (subject != null || body != null)
          ? {
              if (subject != null) 'subject': subject,
              if (body != null) 'body': body,
            }
          : null,
    );
    return await launchURL(uri);
  }

  static Future<bool> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    return await launchURL(uri);
  }

  static Future<bool> sendSMS(
    String phoneNumber, {
    String? body,
  }) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: body == null ? null : <String, String>{'body': body},
    );
    return await launchURL(smsLaunchUri);
  }

  static Future<bool> openGooglePlayMarketApp(String bundleId) async {
    final Uri uri = Uri(scheme: 'market', path: 'details', queryParameters: {'id': bundleId});

    return await launchURL(uri);
  }

  static Future<bool> openAppStoreApp({required String appId}) async {
    // final Uri uri = Uri(scheme: 'itms-apps', path: '/${'${pathSegment?.first ?? ''}/'}/$appId');

    return await launchURL(Uri.parse('https://apps.apple.com/us/app/id$appId'));
  }
}
