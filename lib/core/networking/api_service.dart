import 'api_request.dart';
import 'response_model.dart';

abstract interface class ApiService {
  Future<ApiResponse<T>> callApi<T extends Object?>(
    ApiRequest networkRequest, {
    ApiResponse<T> Function(dynamic json)? mapper,
  });

  void addTokenToRequest(String token);

  void removeTokenFromRequest();
}
