// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  static const String BASE_URL = 'http://192.168.1.25:8000/api/mobile';
  static const int connectTimeoutDurationInSeconds = 30;
  static const int recieveTimeoutDuration = 30;
  static ApiEndPoints endPoints = ApiEndPoints();
}

class ApiEndPoints {
  final String login = '/login';
  final String register = '/register';
  final String logout = '/logout';
  final String sendOTP = '/otp/send';
  final String verifyOTP = '/otp/verify';
  final String verifyPasswordOTP = '/password/otp/verify';
  final String resetPassword = '/password/reset';
}
