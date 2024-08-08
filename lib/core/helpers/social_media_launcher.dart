import 'dart:io';

import 'package:medina_stores/core/helpers/url_launcher_helper.dart';

class SocialMediaLauncher {
  static Future<bool> launchFacebookApp({
    required String identifier,
  }) async {
    final Uri uri = Uri(scheme: 'fb', host: Platform.isIOS ? 'profile' : 'page', path: '/$identifier');
    final fallbackUri = Uri(scheme: 'https', host: 'www.facebook.com', path: '/$identifier');

    final isLaunched = await UrlLauncherHelper.launchURL(uri, fallbackUri: fallbackUri);
    if (!isLaunched) return await UrlLauncherHelper.openAppStoreApp(appId: 'id284882215');
    return isLaunched;
  }

  static Future<bool> launchYoutubeApp({
    String? videoId,
    String? channelId,
    String? playlistId,
  }) async {
    final Uri uri = Uri(
      scheme: 'youtube',
      host: 'www.youtube.com',
      path: videoId != null || playlistId != null ? '/watch' : '/$channelId',
      queryParameters: {
        if (videoId != null) 'v': videoId,
        if (playlistId != null) 'list': playlistId,
      },
    );
    final isLaunched = await UrlLauncherHelper.launchURL(uri);
    if (!isLaunched) {
      return await UrlLauncherHelper.openAppStoreApp(appId: 'id544007664');
    }
    return isLaunched;
  }

  static Future<bool> launchInstagramApp({
    required String identifier,
  }) async {
    try {
      final Uri uri = Uri(scheme: 'instagram', host: identifier);
      final isLaunched = await UrlLauncherHelper.launchURL(uri);
      return isLaunched;
    } catch (e) {
      return await UrlLauncherHelper.openAppStoreApp(appId: 'id389801252');
    }
  }
}
