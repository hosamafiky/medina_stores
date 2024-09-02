// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:medina_stores/core/helpers/firebase_remote_config_helper.dart';

class ApiConstants {
  static const String domain = 'http://api-staging.madinastores.xyz';
  static const String path = 'api/mobile';
  static String BASE_URL = '${FirebaseRemoteConfigHelper.instance.domain}/$path';

  static const int connectTimeoutDurationInSeconds = 30;
  static const int recieveTimeoutDuration = 30;
  static const String dateFormat = 'yyyy MMM dd hh:mm:ss';
  static ApiEndPoints endPoints = ApiEndPoints();
}

class ApiEndPoints {
  // Home
  final String ADS = '/home/sliders';
  final String CATEGORIES = '/home/categories';
  final String SUB_CATEGORIES = '/sub-categories';
  final String BRANDS = '/home/brands';
  final String PRODUCTS = '/products';
  final String PRODUCT = '/product';

  // Auth
  final String login = '/login';
  final String register = '/register';
  final String logout = '/logout';
  final String sendOTP = '/otp/send';
  final String verifyOTP = '/otp/verify';
  final String verifyPasswordOTP = '/password/otp/verify';
  final String resetPassword = '/password/reset';
}
