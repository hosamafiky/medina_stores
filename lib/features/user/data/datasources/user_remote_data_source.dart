part of '../data_imports.dart';

abstract class UserRemoteDataSource {
  Future<ApiResponse<UserModel>> login(LoginParams params);
  Future<ApiResponse<UserModel>> register(RegisterParams params);
  Future<ApiResponse<Null>> sendOTP(SendOTPParams params);
  Future<ApiResponse<Null>> logout();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<ApiResponse<UserModel>> login(LoginParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: "/login", body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponse<UserModel>> register(RegisterParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: "/register", body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponse<Null>> logout() async {
    final request = ApiRequest(method: RequestMethod.post, path: "/logout");
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json),
        );
  }

  @override
  Future<ApiResponse<Null>> sendOTP(SendOTPParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: "/otp/send", body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json),
        );
  }
}
