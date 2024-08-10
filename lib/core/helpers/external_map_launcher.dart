import 'dart:io';

import 'package:medina_stores/core/helpers/url_launcher_helper.dart';

class ExternalMapLauncher {
  static Future<bool> _launchGoogleMapsWithCoordinates({
    required double latitude,
    required double longitude,
    String? title,
  }) async {
    var query = '$latitude,$longitude';
    if (title != null) query += '($title)';
    final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

    return await UrlLauncherHelper.launchURL(uri);
  }

  static Future<bool> _launchGoogleMapsWithQuery(String query) async {
    final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    return await UrlLauncherHelper.launchURL(uri);
  }

  static Future<bool> _launchAppleMapsWithCoordinates({
    required double latitude,
    required double longitude,
    String? title,
  }) async {
    var params = {
      'll': '$latitude,$longitude',
      'q': title ?? '$latitude, $longitude',
    };

    final uri = Uri.https('maps.apple.com', '/', params);
    return await UrlLauncherHelper.launchURL(uri);
  }

  static Future<bool> _launchAppleMapsWithQuery(String query) async {
    final uri = Uri.https('maps.apple.com', '/', {'q': query});
    return await UrlLauncherHelper.launchURL(uri);
  }

  static Future<bool> launchMapWithCoordinates({
    required double latitude,
    required double longitude,
    String? title,
  }) async {
    if (Platform.isAndroid) {
      return await _launchGoogleMapsWithCoordinates(latitude: latitude, longitude: longitude, title: title);
    } else {
      return await _launchAppleMapsWithCoordinates(latitude: latitude, longitude: longitude, title: title);
    }
  }

  static Future<bool> launchMapWithQuery(String query) async {
    if (Platform.isAndroid) {
      return await _launchGoogleMapsWithQuery(query);
    } else {
      return await _launchAppleMapsWithQuery(query);
    }
  }

  static Future<bool> routeBetweenYourPlaceAndOther({
    required double latitude,
    required double longitude,

    /// [mode] can be 'd' for driving, 'w' for walking, 'b' for bicycling or 'l' for two-wheeler.
    String mode = 'd',

    /// [avoid] can be 't' for tolls, 'h' for highways or 'f' for ferries
    List<String> avoid = const [],
  }) async {
    final Uri uri = Uri(
      scheme: 'google.navigation',
      queryParameters: {
        'q': "$latitude,$longitude",
        'mode': mode,
        'avoid': avoid.join(''),
      },
    );
    return await UrlLauncherHelper.launchURL(uri);
  }
}
