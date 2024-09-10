import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../networking/api_constants.dart';

class FirebaseRemoteConfigKeys {
  static const String domain = 'domain';
}

class FirebaseRemoteConfigHelper {
  FirebaseRemoteConfigHelper._() : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigHelper instance = FirebaseRemoteConfigHelper._();
  factory FirebaseRemoteConfigHelper() => instance;

  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) => _remoteConfig.getBool(key);
  int getInt(String key) => _remoteConfig.getInt(key);
  double getDouble(String key) => _remoteConfig.getDouble(key);

  final remoteConfigSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  );

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(remoteConfigSettings);

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          FirebaseRemoteConfigKeys.domain: ApiConstants.domain,
        },
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if (!updated) {
      log('The config is not updated..');
      return;
    }
    log('The config has been updated.');
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }

  String get domain => getString(FirebaseRemoteConfigKeys.domain);
}
