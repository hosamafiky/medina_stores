part of '../data_imports.dart';

abstract class UserRemoteDataSource {
  Future<ApiResponse<UserModel>> login(LoginParams params);
  Future<ApiResponse<UserModel>> register(RegisterParams params);
  Future<ApiResponse<Null>> sendOTP(SendOTPParams params);
  Future<ApiResponse<Null>> verifyPasswordOTP(String otp);
  Future<ApiResponse<UserModel>> verifyOTP(String otp);
  Future<ApiResponse<Null>> resetPassword(ResetPasswordParams params);
  Future<ApiResponse<Null>> logout();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<ApiResponse<UserModel>> login(LoginParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.login, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponse<UserModel>> register(RegisterParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.register, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponse<Null>> logout() async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.logout);
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json),
        );
  }

  @override
  Future<ApiResponse<Null>> sendOTP(SendOTPParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.sendOTP, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
      request,
      mapper: (json) {
        MessageHelper.showSuccessSnackBar(
          "OTP sent successfully : ${json['data']['token']}",
          duration: const Duration(seconds: 10),
        );
        return ApiResponse.fromMapSuccess(json);
      },
    );
  }

  @override
  Future<ApiResponse<UserModel>> verifyOTP(String otp) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.verifyOTP, body: {"token": otp});
    return await DependencyHelper.instance.get<ApiService>().callApi<UserModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json, mapper: UserModel.fromMap),
        );
  }

  @override
  Future<ApiResponse<Null>> verifyPasswordOTP(String otp) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.verifyPasswordOTP, body: {"token": otp});
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json),
        );
  }

  @override
  Future<ApiResponse<Null>> resetPassword(ResetPasswordParams params) async {
    final request = ApiRequest(method: RequestMethod.post, path: ApiConstants.endPoints.resetPassword, body: params.toMap());
    return await DependencyHelper.instance.get<ApiService>().callApi<Null>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(json),
        );
  }
}
