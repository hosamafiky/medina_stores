import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheKeys {
  static const String user = 'user';
  static const String token = 'token';
  static const String themeMode = 'themeMode';
  static const String selectedAddress = 'selectedAddress';

  //DATA
  static const String ads = 'ads';
  static const String brands = 'brands';
  static const String categories = 'categories';
  static const String cart = 'cart';
  static const String suggestedCartProducts = 'suggested-cart-products';
  static const String userAddresses = 'user-addresses';
  static const String latestProducts = 'latest-products';
  static const String favoriteProducts = 'favorite-products';
}

class CacheHelper {
  static late final SharedPreferences _sharedPrefrences;

  static Future<void> init() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
  }

  static Future<void> write(String key, dynamic value) async {
    if (value is String) {
      await _sharedPrefrences.setString(key, value);
    } else if (value is int) {
      await _sharedPrefrences.setInt(key, value);
    } else if (value is double) {
      await _sharedPrefrences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPrefrences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPrefrences.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      await _sharedPrefrences.setString(key, jsonEncode(value));
    }
  }

  static String? _tryDecode(String key) {
    try {
      return jsonDecode(_sharedPrefrences.getString(key)!);
    } catch (e) {
      return _sharedPrefrences.getString(key);
    }
  }

  static dynamic read(String key, {bool isDecoded = false}) {
    if (isDecoded) {
      return _tryDecode(key);
    }
    return _sharedPrefrences.get(key);
  }

  static Future<void> delete(String key) async {
    await _sharedPrefrences.remove(key);
  }

  static Future<void> deleteAll() async {
    await _sharedPrefrences.clear();
  }
}

class SecureStorage {
  SecureStorage._();
  static const _storage = FlutterSecureStorage();

  static Future<void> write(String key, String? value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
