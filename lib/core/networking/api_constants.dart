// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  static const String BASE_URL = 'http://192.168.1.25:8000/api';
  static const int connectTimeoutDurationInSeconds = 60;
  static const int recieveTimeoutDuration = 60;
  static ApiEndPoints endPoints = ApiEndPoints();
}

class ApiEndPoints {
  final String PRODUCTS = '/products';
  final String POSTS = '/posts';
  final String COMMENTS = '/comments';
  final String ALBUMS = '/albums';
  final String PHOTOS = '/photos';
  final String TODOS = '/todos';
  final String USERS = '/users';
}
