import '../standards/response_model.dart';
import 'api_request.dart';

abstract interface class ApiService {
  Future<ApiResponse<T>> callApi<T extends Object?>(
    ApiRequest networkRequest, {
    ApiResponse<T> Function(dynamic json)? mapper,
  });

  void addTokenToRequest(String token);

  void removeTokenFromRequest();
}
