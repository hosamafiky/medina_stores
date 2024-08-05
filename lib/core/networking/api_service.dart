import 'api_request.dart';

abstract interface class ApiService {
  Future<Model> callApi<Model>(
    ApiRequest networkRequest, {
    Model Function(dynamic json)? mapper,
  });

  void addTokenToRequest(String token);

  void removeTokenFromRequest();
}
