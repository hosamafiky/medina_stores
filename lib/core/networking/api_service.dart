import '../standards/response_model.dart';
import 'api_request.dart';

abstract interface class ApiService {
  Future<ApiResponseModel<T>> callApi<T extends Object?>(
    ApiRequest networkRequest, {
    ApiResponseModel<T> Function(dynamic json)? mapper,
  });

  void addTokenToRequest(String token);

  void removeTokenFromRequest();
}
